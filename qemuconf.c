/* See LICENSE file for copyright and license details. */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <limits.h>
#include <string.h>
#include <libgen.h>
#include <ctype.h>
#include <getopt.h>

/*
 * Macros.
 */

#define DROP(x, y)	{ for(y = i; i < len && (x); i++); }
#define BEGINS(x, y)	(strncmp(x, y, strlen(y)) == 0)

/*
 * Function declarations.
 */

static int start();
static int dump();
static int addoptarg(char *arg, int len);
static int addopt(char *opt, int len);
static int compact(char *text, int i, int len, int minindent);
static int parseconfig(char *text, int len);
static int loadconfig(char *path);
static void print_version();
static void print_help();

/*
 * Variables.
 */

char **cargv;
char **curopt = NULL;
char *cwd = ".";
static char *qemubin = NULL;
int cargc = 1;
int maxargc = 0;

/*
 * Function implementations.
 */

int
start()
{
	if (chdir(cwd)) {
		perror(cwd);
		return 1;
	}
	execvp(qemubin, cargv);
	perror(qemubin);
	return 1;
}

int
dump()
{
	int i;

	fputs(cargv[0], stdout);
	for (i = 1; i < cargc; i++) {
		fputc(' ', stdout);
		fputs(cargv[i], stdout);
	}
	fputc('\n', stdout);
	return 0;
}

int
addoptarg(char *arg, int len)
{
	arg[len] = '\0';
	if (curopt != NULL) {
		*curopt = arg;
		curopt = NULL;
		return 0;
	}
	cargv[cargc] = arg;
	if (++cargc == maxargc) {
		fputs("Too many args", stderr);
		return 1;
	}
	cargv[cargc] = NULL;

	return 0;
}

int
addopt(char *opt, int len) 
{
	char *optdup;
	if (BEGINS(opt, "cwd"))
		curopt = &cwd;
	else if (BEGINS(opt, "qemubin"))
		curopt = &qemubin;
	else {
		if (!(optdup = calloc(sizeof(char), len + 2))) {
			perror("malloc");
			return 1;
		}
		optdup[0] = '-';
		memcpy(optdup+1, opt, len);
		return addoptarg(optdup, len + 1);
	}
	return 0;
}

int
compact(char *text, int i, int len, int minindent)
{
	int _i, curindent, w=i, line = 0;

	for (curindent = 0, line = 0; i < len; line++, i++) {
		DROP(isspace(text[i]) && text[i] != '\n', _i);
		curindent = i - _i;

		if (text[i] == '#' || text[i] == '\n') {
			DROP(text[i] != '\n', i);
			continue;
		}
		else if (line != 0 && curindent <= minindent)
			break;

		DROP(isalnum(text[i]), _i);
		memmove(&text[w], &text[_i], i - _i);
		w += i - _i;
		DROP(isspace(text[i]) && text[i] != '\n', _i);
		if (_i != i)
			text[w++] = '=';
		DROP(text[i] != '\n', _i);
		memmove(&text[w], &text[_i], i - _i);
		w += i - _i;
		text[w++] = ',';
		curindent = 0;
	}
	memset(&text[w], ' ', i - curindent - w);
	memset(&text[w-1], '\n', line - 1);
	text[i-curindent-1] = '\n';
	return 0;
}

int
parseconfig(char *text, int len)
{
	int i = 0, _i, line, linestart, curindent;

	for (linestart = i = line = 0; i < len; line++, linestart = ++i) {
		DROP(isspace(text[i]) && text[i] != '\n', _i);
		curindent = i - _i;
		if (i >= len)
			break;

		if (text[i] == '\n')
			continue;
		if (text[i] == '#') {
			DROP(text[i] != '\n', i);
			continue;
		}

		if (text[i] == '.') {
			i++;
			DROP(isspace(text[i]), i);
			DROP(text[i] != '\n', _i);
			text[i] = '\0';
			if (loadconfig(&text[_i])) {
				fprintf(stderr, "Error at line %i. ", line + 1);
				return 1;
			}
			continue;
		}

		DROP(isalnum(text[i]) || text[i] == '-', _i);

		addopt(&text[_i], i - _i);

		DROP(isspace(text[i]) && text[i] != '\n', i);
		if (text[i] == '\n')
			continue;
		else if (text[i] == ':' || i != _i) {
			if (text[i] == ':')
				_i = ++i;
			else {
				DROP(isspace(text[i]) && text[i] != '\n', i);
				DROP(text[i] != '\n', _i);
			}

			if (text[i-1] == ':') {
				text[i-1] = ',';
				if (compact(text, i, len, curindent)) {
					fprintf(stderr, "at line %i character %i. ",
						line + 1, i - linestart);
					return 1;
				}
				DROP(text[i] != '\n', i);
			}

			addoptarg(&text[_i], i - _i);
		} else if (i == _i) {
			fprintf(stderr, "Expected whitespace or ':' instead of '%c' at line %i character %i. ",
				text[i], line + 1, i - linestart);
			return 1;
		}
	}
	return 0;
}

int
loadconfig(char *path)
{
	int r = 0, len = 0;
	char *text = NULL, *wd;
	char oldwd[PATH_MAX+1] = { 0 };
	FILE *file;
	char *pathdup = strdup(path);

	if (!(file = fopen(path, "r"))) {
		perror(path);
		return 1;
	}

	if (!getcwd(oldwd, sizeof(oldwd))) {
		perror("getcwd");
		return EXIT_FAILURE;
	}

	wd = dirname(pathdup);
	if (chdir(wd)) {
		perror(wd);
		return 1;
	}

	do {
		len += r;
		text = realloc(text, sizeof(char) * (len + BUFSIZ));
	} while ((r = fread(text, sizeof(char), (len + BUFSIZ - 1), file)) > 0);
	text[len] = 0;

	if (ferror(file)) {
		perror(path);
		return 1;
	}

	if (parseconfig(text, strlen(text))) {
		fprintf(stderr, "At file '%s'\n", path);
		return 1;
	}

	if (chdir(oldwd)) {
		perror(oldwd);
		return 1;
	}
	free(pathdup);

	return 0;
}

static void
print_version()
{
	printf("qemuconf "VERSION);
}

static void
print_help()
{
	printf("Usage: qemuconf [OPTIONS] config [-- [qemu_options]...]\n"
	       "Simple Qemu launcher with configuration files support\n\n"
	       "Options:\n"
	       "  -q EXEC, --qemubin=EXEC  Path to qemu binary (default: " QEMU_BIN ").\n"
	       "  -n,      --no-execute    Dump qemu command line to stdout, don't execute.\n"
	       "  -v,      --version       Print version and exit.\n"
	       "  -h,      --help          Show this help message and exit.\n\n"
	       "Arguments:\n"
	       "  config                   Configuration file path.\n"
	       "  -- [qemu_options]...     Optional arguments passed directly to qemu.\n");
}


int
main(int argc, char *argv[])
{
	int opt;
	char *cmdline_qemubin = NULL;
	int (*action)() = start;

	static struct option long_options[] = {
		{"qemubin",    required_argument, NULL, 'q'},
		{"no-execute", no_argument,       NULL, 'n'},
		{"version",    no_argument,       NULL, 'v'},
		{"help",       no_argument,       NULL, 'h'},
		{0,            0,                 NULL,  0 }
	};

	while ((opt = getopt_long(argc, argv, "hnq:v", long_options, 0)) != -1) {
		switch (opt) {
			case 'q':
				cmdline_qemubin = optarg;
				break;
			case 'n':
				action = dump;
				break;
			case 'v':
				print_version();
				return EXIT_SUCCESS;
			case 'h':
				print_help();
				return EXIT_SUCCESS;
			case '?':
			default:
				print_help();
				return EXIT_FAILURE;
		}
	}

	if (optind >= argc) {
		print_help();
		return EXIT_FAILURE;
	}

	if ((maxargc = sysconf(_SC_ARG_MAX)) < 0) {
		perror("sysconf");
		return EXIT_FAILURE;
	}

	if (!(cargv = calloc(sizeof(char *), maxargc))) {
		perror("calloc");
		return EXIT_FAILURE;
	}

	if (loadconfig(argv[optind++]))
		return EXIT_FAILURE;

	for (; optind < argc; optind++, cargc++)
		cargv[cargc] = argv[optind];

	if (cmdline_qemubin) cargv[0] = cmdline_qemubin;
	else if (qemubin)    cargv[0] = qemubin;
	else                 cargv[0] = QEMU_BIN;

	if (action())
		return EXIT_FAILURE;

	return EXIT_SUCCESS;
}

/* End of file. */
