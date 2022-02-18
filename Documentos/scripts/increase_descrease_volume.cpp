#include <stdlib.h> 
#include <stdio.h>
#include <string.h>
#include <string>
#include <unistd.h>
#include <stdarg.h>
#include <memory>
#include <sys/ioctl.h>
#include <boost/format.hpp>
#include <boost/process.hpp>
#include <iostream>
#include <regex>
#include <iterator>
#include <glob.h>
#include <pcre.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <fstream>
#include <numeric>
#include <string_view>
#include <wordexp.h>
#define PIPE_READ 0
#define PIPE_WRITE 1
void convertMainArgs(int argc, const char *argv[], int maxargs){
char str[50];

if (argc > 1) {
    sprintf(str, "%d", argc - 1);
    setenv("#", str, 1);
}
else  setenv("#", "0", 1);
std::string combinedargs;
int sz = 0;
for (int i = 1; i < argc; i++)
    sz += strlen(argv[i]) + 1;
combinedargs.reserve(sz);
setenv("0", argv[0], 1);
for (int i = 1; i < argc; i++) {
    sprintf(str, "%d", i);
    setenv(str, argv[i], 1);
    combinedargs += argv[i];
    if (i != (argc - 1)) combinedargs += " ";
}
if (combinedargs.length() == 0) combinedargs = " ";
setenv("@", combinedargs.c_str(), 1);
for (int i = argc; i < (maxargs + 1); i++) {
    sprintf(str, "%d", i);
    setenv(str, " ", 1);
}
}

        const int fileexists(const std::string_view &file) {
            struct stat buf;                        
            if (file == "") return true; 
                return (stat(file.data(), &buf) == 0);        
        }
        off_t filesize(const char* filename)
        {
			struct stat st;
			if (stat(filename, &st)) return 0;
			off_t size = st.st_size;
            return size;
        }
        const int fileexists_sizenonzero(const std::string_view &file) {
            if (fileexists(file)){        
                return filesize(file.data()) != 0;
            }
            return 0;
        }

        const int regularfileexists(const std::string_view &file) {          
            struct stat buf;                        
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISREG(buf.st_mode);        
        }

        const int pipefileexists(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && (buf.st_mode & S_IFIFO);        
        }

        const int linkfileexists(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISLNK(buf.st_mode);        
        }

        const int socketfileexists(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISSOCK(buf.st_mode);        
        }

        const int blockfileexists(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISBLK(buf.st_mode);        
        }

        const int charfileexists(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISCHR(buf.st_mode);        
        }

        const int filereadable(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) &&  (buf.st_mode & S_IRUSR);        
        }

        const int fileexecutable(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) &&  (buf.st_mode & S_IXUSR);        
        }

        const int filewritable(const std::string_view &file) {          
            struct stat buf;                        
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) &&  (buf.st_mode & S_IWUSR);        
        }

        const int direxists(const std::string_view &file) {                                   
            struct stat buf;                                                
            if (file == "") return true; 
            return fileexists(file) && (stat(file.data(), &buf) == 0) && S_ISDIR(buf.st_mode);        
        }

        const int mystoi(const std::string_view &str, int defreturn = -1) { 
            if (!str.empty()) return std::stoi(str.data()); 
            return defreturn; 
        }
        const int mystoiz(const char *str) { 
            if (str && (str[0] != 0)) return atoi(str); 
            return 0; 
        }
        
        const std::string get_env(const std::string_view &cmd) { 
            const char *env = getenv(cmd.data());
            return env ? env : ""; 
        }
        void get_env(std::string &envstr, const std::string_view &cmd) { 
            const char *env = getenv(cmd.data());
            envstr = env ? env : ""; 
        }
        
        const int envexists_and_hascontent(const std::string_view &cmd) { 
            char *env = getenv(cmd.data()); 
            return env ? env[0] != '\0' > 0 : 0; 
        }
        
        const int envempty(const std::string_view &cmd) { 
            char *env = getenv(cmd.data()); 
            return env ? env[0] == '\0' : true; 
        }
        const int envset(const std::string_view &cmd) { 
            char *env = getenv(cmd.data()); 
            return env ? true : false; 
        }
        
        const std::string_view set_env(const char *cmd, const std::string &value) { 
            if (value.back() == '\n')
                setenv(cmd, value.substr(0, value.length()-1).c_str(), 1);
            else 
                setenv(cmd, value.c_str(), 1);
            return "";
        }
        
        const std::string_view set_env(const char *cmd, const float value) { 
            char c[64];
            sprintf(c, "%f", value);
            setenv(cmd, c, 1);
            return "";
        }
        
        const std::string_view set_env(const char *cmd, const int value) { 
            char c[64];
            sprintf(c, "%d", value);
            setenv(cmd, c, 1);
            return "";
        }
        
        void set_env(const char *cmd, const char value) { 
            char c[2];
            c[0] = value;
            c[1] = 0;
            setenv(cmd, c, 1);
        }
        const std::string set_env_ifunset(const char *cmd, const std::string_view &value) {
        
            char *env = getenv(cmd); 
            if (!env) { setenv(cmd, value.data(), 1); return std::string(value.data()); } 
            return env;
        }
        const std::string set_env_ifempty(const char *cmd, const std::string_view &value) { 
            char *env = getenv(cmd); 
            if (!env) { setenv(cmd, value.data(), 1); return std::string(value);}
            if (envempty(cmd)) { setenv(cmd, value.data(), 1); return std::string(value.data());}
            return env;
        }

int createChild(int *outfd, char ** aArguments) {
    int aStdinPipe[2];
    int aStdoutPipe[2];
    int nChild;
    char nChar;
    int nResult;

    if (pipe(aStdinPipe) < 0) {
        fprintf( stderr,"%s:%d\n", __func__, __LINE__);
        exit(-1);
    }
    if (pipe(aStdoutPipe) < 0) {
        close(aStdinPipe[PIPE_READ]);
        close(aStdinPipe[PIPE_WRITE]);
        fprintf( stderr,"%s:%d\n", __func__, __LINE__);
        exit(-1);
    }

    nChild = fork();
    if (0 == nChild) {
        close(outfd[0]);
        if (dup2(outfd[1], STDOUT_FILENO) == -1) {
            fprintf( stderr,"%s:%d\n", __func__, __LINE__);
            exit(errno);
        }

        if (dup2(outfd[1], STDERR_FILENO) == -1) {
            fprintf( stderr,"%s:%d\n", __func__, __LINE__);
            exit(errno);
        }

        close(aStdinPipe[PIPE_READ]);
        close(aStdinPipe[PIPE_WRITE]);
        close(aStdoutPipe[PIPE_READ]);
        close(aStdoutPipe[PIPE_WRITE]);

        nResult = execvpe(aArguments[0], &aArguments[0], environ);

        exit(nResult);
    } else if (nChild > 0) {
        close(outfd[1]);
        close(aStdinPipe[PIPE_READ]);
        close(aStdoutPipe[PIPE_WRITE]);
        close(aStdinPipe[PIPE_WRITE]);
        close(aStdoutPipe[PIPE_READ]);

        int rc;
        if (waitpid(nChild, &rc, 0) != -1) {
            if (WIFEXITED(rc)) {
                nChild = WEXITSTATUS(rc);
            }
        }
    } else {
        close(aStdinPipe[PIPE_READ]);
        close(aStdinPipe[PIPE_WRITE]);
        close(aStdoutPipe[PIPE_READ]);
        close(aStdoutPipe[PIPE_WRITE]);
    }
    return nChild;
}

void execcommand(int *outfd, const std::string_view &cmd, int & exitstatus) 
{
    wordexp_t p;
    char **w;
    int ret;
        
    ret = wordexp(cmd.data(), &p, 0);
    if (ret) {
        fprintf( stderr,"%s:%d\n", __func__, __LINE__);
        exit(-1);
     };
    w = p.we_wordv;
    exitstatus = createChild(outfd, &w[0]);
    wordfree(&p);
}
        
        const void writetoout(int *outfd, std::string &result, bool stdout, bool resultcollect) { 
            char nChar;
            size_t available = 0;
            if (read(outfd[0], &nChar, 1) == 1) {
                ioctl(outfd[0], FIONREAD, &available);
                if (resultcollect) {
                    if (available) result.resize(available + 1);
					result[0] = nChar;
					if (available && read(outfd[0], &result[1], available) < 0) {
						fprintf( stderr,"%s:%d\n", __func__, __LINE__);
						exit(-1);
					}
                    if (stdout) std::cout << result; 
                }
                else if (stdout) {
                    const int bufsize = 4096;
                    char databuf[bufsize + 1];
                    databuf[bufsize] = 0;
					if (stdout)
						std::cout << nChar;
					
					int count = available / bufsize;
                    while (count) {
                        if (read(outfd[0], &databuf[0], bufsize) < 0) break;
                        std::cout << databuf;
                        count--;
                    }
					int remaining = (available % bufsize);
					if (remaining) {
						if (read(outfd[0], &databuf[0], remaining) > 0) {
						databuf[remaining] = 0;
						if (stdout)
							std::cout << databuf;
						}
					}
                }
            }
            close(outfd[0]); 
        } 
        const int checkexec(const std::string_view &cmd) { 
            int exitstatus; 
            if (!cmd.empty()) {
                std::string result;
                int outfd[2];
                if (pipe(outfd) < 0) {
                    fprintf( stderr,"%s:%d\n", __func__, __LINE__);
                    exit(-1);
                }
                bool stdout = true;
 bool resultcollect = false;
                execcommand(outfd, cmd, exitstatus);
                writetoout(outfd, result, stdout, resultcollect);
                set_env("?", exitstatus);
            } else {
                exitstatus = mystoiz(getenv("?"));
            }
            return exitstatus == 0; 
        }
        const int checkknownexec(const std::string_view &cmd) { 
            int exitstatus; 
            if (!cmd.empty()) {
                if (cmd == "0") return true;
                if (cmd == "1") return false;
            }
            exitstatus = mystoiz(getenv("?"));
            return exitstatus == 0; 
        }
        const int checkexitcode(const std::string &cmd) { 
            int exitstatus; 
            exitstatus = mystoiz(getenv("?"));
            return exitstatus == 0; 
        }
        
        const std::string exec(const std::string_view &cmd, bool  resultcollect = true) {
            int exitstatus; 
            std::string result;
            char nChar;
            int outfd[2];
            if (pipe(outfd) < 0) {
                fprintf( stderr,"%s:%d\n", __func__, __LINE__);
                exit(-1);
            }
            execcommand(outfd, cmd, exitstatus);
            writetoout(outfd, result, stdout, resultcollect);
            set_env("?", exitstatus);
            return result; 
        }
        
        const void execnoresult(const std::string_view &cmd) {
            int exitstatus; 
            std::string result;
            char nChar;
            int outfd[2];
            if (pipe(outfd) < 0) {
                fprintf( stderr,"%s:%d\n", __func__, __LINE__);
                exit(-1);
            }
            bool stdout = true;
 bool resultcollect = false;
            execcommand(outfd, cmd, exitstatus);
            writetoout(outfd, result, stdout, resultcollect);
            set_env("?", exitstatus);
        }
        
        const std::string execnoout(const std::string_view &cmd, bool resultcollect = true) {
            int exitstatus; 
            std::string result; 
            char nChar;
            int outfd[2];
            if (pipe(outfd) < 0) {
                fprintf( stderr,"%s:%d\n", __func__, __LINE__);
                exit(-1);
            }
            bool stdout = false;
            execcommand(outfd, cmd, exitstatus);
            writetoout(outfd, result, stdout, resultcollect);
            set_env("?", exitstatus);
            return result; 
        }

        void split(std::vector <std::string> &tokens, const std::string &str, std::string &delimiter)
        {
            // Vector of string to save tokens  
            size_t pos = 0; 
            size_t prev = 0; 
            if (str.front() == '\'') prev++;
                                                
            while ((pos = str.find_first_of(delimiter, prev)) != std::string::npos) {
                if (pos > prev)
                    tokens.emplace_back(str.substr(prev, pos-prev));
                prev = pos+1;
            }
            if (prev < str.length()){
                size_t end = str.length() - prev;
                if (str.back() == '\'') end--;
                tokens.emplace_back(str.substr(prev, end));
            }
        }
        
        const std::vector <std::string> split(const std::string_view &s, bool ifs = true) {
            std::string delim(" \t\n"); 
            std::vector <std::string> elems;
            const char *userdelim = getenv("IFS");
            if ((userdelim != NULL) && ifs)
            {
                delim = userdelim;
            }
            { 
                split(elems, std::string(s.data()), delim); 
            }
            return elems;
        }
        void split(std::vector <std::string> &elems, const std::string_view &s, bool ifs= true) {
            std::string delim(" \t\n"); 
            const char *userdelim = getenv("IFS");
            if ((userdelim != NULL) && ifs)
            {
                delim = userdelim;
            }
            { 
                split(elems, std::string(s.data()), delim); 
            }
        }

        const bool regexmatch(const std::string_view &subject, const std::string_view &pattern)
        {
            pcre *re;
            const char *error;
            int erroffset;
            int ovector[30];
            int subject_length;
            int rc;
            
            subject_length = (int)subject.length();
            
            re = pcre_compile(pattern.data(), 0, &error, &erroffset, NULL); 
            if (re == NULL) return 0; 
                                        
            rc = pcre_exec(re, NULL, subject.data(),           
                subject_length, 0, PCRE_ANCHORED,               
                ovector, sizeof(ovector) / sizeof(ovector[0])); 
                                                                
            if (rc < 0) {                                       
                pcre_free(re);                                  
                return 0;                                       
            }                                                   
            pcre_free(re);                                      
            return 1;                                           
        }                                                       
        
        const bool isregexstring(const std::string_view &str)
        {
            if (str.find_first_of("*?", 0) != std::string::npos)
                return true;
            return false;
        }
        
        const std::vector<std::string> globvector(const std::string_view& pattern){
            glob_t glob_result;
            glob(pattern.data(), GLOB_TILDE, NULL,& glob_result);
            std::vector <std::string> files;
            files.reserve(glob_result.gl_pathc);
            for (unsigned int i = 0; i < glob_result.gl_pathc; ++i) {
                files.emplace_back(std::string(glob_result.gl_pathv[i]));
            }
            globfree(& glob_result);
            return files;
        }
        void globvector(std::vector<std::string> &elems, const std::string_view& pattern){
            glob_t glob_result;
            glob(pattern.data(), GLOB_TILDE, NULL,& glob_result);
            elems.reserve(glob_result.gl_pathc);
            for (unsigned int i = 0; i < glob_result.gl_pathc; ++i) {
                elems.emplace_back(std::string(glob_result.gl_pathv[i]));
            }
            globfree(& glob_result);
        }
        
        const std::vector <std::string> regexsplit(const std::string_view &str)
        {
            if (isregexstring(str)) {
                return globvector(str);
            }
            return split(str);
        }
        void regexsplit(std::vector <std::string> &list, const std::string_view &str)
        {
            if (isregexstring(str)) {
                globvector(list, str);
                return;
            }
            split(list, str);
        }

        void echom(const std::string_view &str, size_t endoffset = std::string::npos)
        {
            size_t startoffset = 0;
            bool endprint = true;
            size_t offset = str.find("-n"); 
            if (offset != std::string::npos) {
                startoffset = 3;
                endprint = false;
            }
            if (endprint && (endoffset == std::string::npos) && str.back() == ' ') {
                endoffset = str.length() - 1;
            }
            while (endprint && endoffset && (endoffset != std::string::npos) && str[endoffset - 1] == ' ') {
                endoffset--;
            }
            {
                size_t initial_pos = startoffset;
                size_t start_pos = startoffset;
                int spacelen = std::string("  ").length();
                while ((start_pos = str.find("  ", start_pos)) != std::string::npos) {
                    std::cout << str.substr(initial_pos, start_pos - initial_pos) << " "; 
                    start_pos += spacelen; 
                    initial_pos = start_pos; 
                }
                if (endoffset != std::string::npos)
                    std::cout << str.substr(initial_pos, endoffset - initial_pos); 
                else 
                    std::cout << str.substr(initial_pos, endoffset); 
            }
            if (endprint) std::cout << std::endl; 
            set_env("?", 0);
        }
        
        void echov(const std::string_view &str)
        {
            size_t endoffset = str.find_last_not_of("\n");
            if (endoffset != std::string::npos) {
                echom(str, endoffset + 1);
            } else {
                echom(str);
            }
        }
        
        const std::string ifscombine(const std::vector<std::string> &vec)
        {
            const std::string separator(get_env("IFS"));
            std::string str("");
            int vecsize = vec.size();
            for (int i = 0; i < vecsize; i++) {
                str += vec[i];
                if (i != (vecsize - 1))
                    str += separator;
            }
            return (str); 
        }
auto format_vector(boost::format fmt, const std::vector<char *> &v) {
    for(const auto &s : v) {
        fmt = fmt % s;
    }
    return fmt;
}
        void printf(const std::string_view &str)
        {
            std::vector<char *> toks;
            wordexp_t p;
            char **w;
            int ret;
                
            ret = wordexp(str.data(), &p, 0);
            if (ret) {
                fprintf( stderr,"%s:%d\n", __func__, __LINE__);
                exit(-1);
             };
            w = p.we_wordv;
            toks.reserve(p.we_wordc);
            for (int i = 0; i < p.we_wordc; i++) {
                toks.emplace_back(w[i]);
            }
            boost::format fmt(toks[0]);
            toks.erase(toks.begin());
            std::stringstream outstr;
            std::string strval(format_vector(fmt, toks).str());
            std::vector <std::string> tokens;
            std::string delim("\\n"); 
            split(tokens, strval, delim);
            for (auto &a : tokens)
                std::cout << a << std::endl;
            wordfree(&p);
            set_env("?", 0);
        }
        
        void echo(const std::string_view &str)
        {
            echov(str); 
            set_env("?", 0);
        }
        
        void echo(const float value) {
            std::cout << value << std::endl; 
            set_env("?", 0);
        }
        
        void echo(const int value) {
            std::cout << value << std::endl; 
            set_env("?", 0);
        }

        void cd(const std::string_view &directory) {
            std::vector<char> cwd;
            if (chdir(directory.data())) return;
            long size = pathconf(".", _PC_PATH_MAX);
            cwd.reserve(size);
            setenv("PWD", getcwd(cwd.data(), (size_t)size), 1);
            set_env("?", 0);
        }

        std::streambuf *stdoutbackup = std::cout.rdbuf();
        void bashexit(int code) {
            int c;
            std::streambuf *current = std::cout.rdbuf();
            std::cout.rdbuf(stdoutbackup);
            int n = current->in_avail();
			if ((c = current->sgetc()) != EOF) printf("%c", c); 
			while ((c = current->snextc()) != EOF) printf("%c", c); 
            exit(code);
        }

        const std::string readval(const std::string_view &var) {
            std::string line;
            if (!std::getline(std::cin, line)) {
                set_env("?", -1);
                return "";
            }
            std::vector <std::string> tokens;
            std::vector <std::string> keys;
            split(keys, var);
            tokens.reserve(keys.size());
            split(tokens, line);
            int tokensize = tokens.size();
            int keysize = keys.size();
            if (tokensize) {
                int i = 0;
                for (int j = 0; j < tokensize; j++) {
                    if (i == keysize)
                        break;
                    setenv(keys[i].c_str(), tokens[j].c_str(), 1);
                    i++;
                }
                if (tokensize > keysize) {
                    int first = keysize - 1;
                    int last = tokensize;
                    std::string s;
                    s.reserve(line.length());
                    for (int count = first; count < last; count++) {
                        s += tokens[count];
                        if (count != (tokensize - 1))
                            s +=  " ";
                    }
                    setenv(keys.back().c_str(), s.c_str(), 1);
                }
            } else {
                if (keysize)
                    set_env(keys[0].c_str(), line);
                else 
                    set_env(var.data(), line);
            }
            set_env("?", 0);
            return "";
        }
        
        const std::string readval(void) {
            return readval("REPLY");
        }

        const std::string pre_increment(const char *variable) {
            int val = mystoiz(getenv(variable)) + 1;
            set_env(variable, val);
            return std::to_string(val);
        }
        const std::string post_increment(const char *variable) {
            int initval = mystoiz(getenv(variable));
            int val = initval + 1;
            set_env(variable, val);
            return std::to_string(initval);
        }
        const std::string pre_decrement(const char *variable) {
            int val = mystoiz(getenv(variable)) - 1;
            set_env(variable, val);
            return std::to_string(val);
        }
        const std::string post_decrement(const char *variable) {
            int initval = mystoiz(getenv(variable));
            int val = initval - 1;
            set_env(variable, val);
            return std::to_string(initval);
        }
        
void restoreargs(const std::vector<std::string> &list, int maxargs)
{
    char str[50];
    for (int i = 0; i < maxargs; i++) {
        sprintf(str, "%d", i + 1);
        setenv(str, list[i].c_str(), 1);
    }
}
void saveargs(std::vector<std::string> &list, int maxargs)
{
    char str[50];
    list.reserve(maxargs);
    for (int i = 0; i < maxargs; i++) {
        sprintf(str, "%d", i + 1);
        list.emplace_back(get_env(str));
    }
}
void processargs(const std::initializer_list<std::string> &list, int maxargs)
{
    int i = 0, sz = 0;
    std::string combinedargs;
    for (auto &elem : list )
        sz += elem.size() + 1;
    combinedargs.reserve(sz);
    int listsize = list.size();
    set_env("#", listsize);
    char str[50];
    for (auto &elem : list )
    {
        sprintf(str, "%d", i + 1);
        setenv(str, elem.c_str(), 1);
        combinedargs += elem;
        if (i != (listsize - 1)) combinedargs += " ";
        i++;
    }
    for (int i = listsize + 1; i < (maxargs + 1); i++) {
        sprintf(str, "%d", i);
        setenv(str, " ", 1);
    }
    if (combinedargs.length() == 0) combinedargs = " ";
        set_env("@", combinedargs);
}
class scopeexitcerrfile{
    std::streambuf *m_backup;
    std::ofstream m_redirectStream;
public:
    scopeexitcerrfile(const std::string &file, bool append = false) {
        append ? m_redirectStream = std::ofstream(file, std::ios_base::app): m_redirectStream = std::ofstream(file);
        m_backup = std::cerr.rdbuf();
        if (m_redirectStream) std::cerr.rdbuf(m_redirectStream.rdbuf());
    }
    ~scopeexitcerrfile(){std::cerr.rdbuf(m_backup);}
};
class scopeparams{
    int m_maxargs;
    std::vector<std::string> m_vec;
public:
    scopeparams(const std::initializer_list<std::string> &list, int maxargs): m_maxargs(maxargs) {
        saveargs(m_vec, maxargs);
        processargs(list, maxargs);
    }
    ~scopeparams(){restoreargs(m_vec, m_maxargs);}
};
class scopeexitcincout {
    
    std::streambuf *backupout = std::cout.rdbuf();
	std::streambuf *backupin = std::cin.rdbuf();
	std::stringstream buffer;
	int readfd[2];
	int m_inbackup;
	bool m_released = false;

	public: 

	~scopeexitcincout() {
		release();
	}
	scopeexitcincout(bool stdout = false) {
		if (!stdout) std::cout.rdbuf(buffer.rdbuf());
        if (pipe(readfd) < 0) {
            fprintf( stderr,"%s:%d\n", __func__, __LINE__);
            exit(-1);
        }
		m_inbackup = dup(0);
		dup2(readfd[0], STDIN_FILENO); 
		close(readfd[0]);
	}

	std::stringstream &buf() { return buffer;}

	void release() {
		if (m_released) return;

		std::cout.rdbuf(backupout);
		std::cin.rdbuf(backupin);
		dup2(m_inbackup, 0); 
		close(m_inbackup); 
		m_released = true;
	}

	void writecin(std::stringstream &str) {
		if (write(readfd[1], str.str().data(), str.str().length()) < 0) {
			fprintf( stderr,"%s:%d\n", __func__, __LINE__);
			exit(-1);
		}
		close(readfd[1]);
	}
};
class scopeexitcinfile {
    
        int m_backup; 
        int m_redirectStream; 
        public: 
        scopeexitcinfile(const std::string &file) {
        
            m_redirectStream = open(file.c_str(), O_RDONLY); 
            m_backup = dup(0); 
            if (m_redirectStream >= 0) {
            
                dup2(m_redirectStream, STDIN_FILENO); 
                close(m_redirectStream); 
            } 
        } 
        ~scopeexitcinfile() {
        
            dup2(m_backup, 0); 
            close(m_backup); 
        } 
    }; 
class scopeexitcoutfile{
    std::streambuf *m_backup;
    std::ofstream m_redirectStream;
    public:
    scopeexitcoutfile(const std::string &file, bool append = false) {
        append ? m_redirectStream = std::ofstream(file, std::ios_base::app): m_redirectStream = std::ofstream(file);
        m_backup = std::cout.rdbuf();
        if (m_redirectStream) std::cout.rdbuf(m_redirectStream.rdbuf());
    }
    ~scopeexitcoutfile(){std::cout.rdbuf(m_backup);}
};
class scopeexitcout{
    bool m_stdout = false;
    std::streambuf *m_backup;
    std::stringstream m_redirectStream;
    bool m_released = false;    public:
    std::stringstream &buf(){ return m_redirectStream;} 
    scopeexitcout(bool stdout = false){
        m_stdout = stdout;
        m_backup = std::cout.rdbuf();
        std::cout.rdbuf(m_redirectStream.rdbuf());
    }
    ~scopeexitcout(){release();}
    void release(){if (m_released) return; std::cout.rdbuf(m_backup); if (m_stdout) std::cout << m_redirectStream.str(); m_released = true;}
};
class scopedvariable{
    std::string m_backup;
    std::string m_env;
    public:
    scopedvariable(const std::string_view &env, const std::string_view &newval) {
        m_env = env;
        get_env(m_backup, env);
        set_env(env.data(), newval.data());
    }
    scopedvariable(const std::string_view &env) {
        m_env = env;
        get_env(m_backup, env);
    }
    ~scopedvariable(){setenv(m_env.c_str(), m_backup.c_str(), 1);}
};
        template <typename F>
        const std::string execinternal(F f)
        {
            scopeexitcout scope(false);
            f({});
            return scope.buf().str();
        }
        const std::string execbuiltin(void (*f)(const std::string_view &arg), const std::string_view &arg)
        {
            scopeexitcout scope(false);
            f(arg);
            return scope.buf().str();
        }
        const int checkbuiltinexec(void (*f)(const std::string_view &arg), const std::string_view &arg) { 
            f(arg);
            int exitstatus; 
            exitstatus = mystoiz(getenv("?"));
            return exitstatus == 0; 
        }
const std::string upper(const std::string_view &str)
{
    std::string s(str);
    std::transform(s.begin(), s.end(), s.begin(), ::toupper);
    return s;
}
const std::string lower(const std::string_view &str)
{
    std::string s(str);
    std::transform(s.begin(), s.end(), s.begin(), ::tolower);
    return s;
}
const std::string uppercapitalize(const std::string_view &str)
{
    std::string s(str);
    s[0] = toupper(s[0]);
    return s;
}
const std::string lowercapitalize(const std::string_view &str)
{
    std::string s(str);
    s[0] = tolower(s[0]);
    return s;
}
void source(const std::string_view &fname)
{
int exitstatus;
std::string result;
std::string cmd("set -a && . ");
cmd.reserve(cmd.size() + fname.size() + 19);
cmd += fname;
cmd += " && set +a && env";
char *toks[4] = {(char*)"sh", (char*)"-c", cmd.data(), (char*)NULL};
boost::process::ipstream pipe_stream;
cmd = "sh -c \"" + cmd + "\"";
boost::process::child c(cmd, boost::process::std_out > pipe_stream);
std::string line;
while (pipe_stream && std::getline(pipe_stream, line) && !line.empty()) {
   size_t offset = line.find("=");
                if (line[0] == '#') continue;
                if (offset != std::string::npos) {;
                    std::string key(line.substr(0, offset));
                    std::string value(line.substr(offset + 1));
                    if (!value.empty()){ 
                        setenv(key.data(), value.data(), 1);
                    }
                }
};
c.wait();
}


void asyncs0(void);
void asyncs1(void);
void asyncs2(void);
void wait();




void asyncs0(void){
pid_t pid = fork();
if (pid > 0) {return;}
exec("mpg123 -q /home/lucas/Documentos/scripts/increase_descrease_volume.mp3");
exit(0);
}

void asyncs1(void){
pid_t pid = fork();
if (pid > 0) {return;}
exec(std::string("pactl ") + "-- set-sink-volume" + std::string(" ") + execnoout("pactl get-default-sink") + std::string(" ") + std::string(" ") + "+" + get_env("step") + "%");
exit(0);
}

void asyncs2(void){
pid_t pid = fork();
if (pid > 0) {return;}
exec(std::string("pactl ") + "-- set-sink-volume" + std::string(" ") + execnoout("pactl get-default-sink") + std::string(" ") + std::string(" ") + "-" + get_env("step") + "%");
exit(0);
}

void wait()
{
    waitpid(-1, NULL, 0);
}



int main(int argc, const char *argv[]) {
convertMainArgs(argc, argv, 1);
setenv("step", "3", 1);
if (envexists_and_hascontent("1")) { 
asyncs0();
;
if (get_env("1")=="increase") { 
asyncs1();
;

}
else if (get_env("1")=="decrease") { 
asyncs2();
;

}
;;;

}
;;
return 0;
} 
