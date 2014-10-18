CC			= gcc
#CC_FLAGS	= -Wall -g -I $(HOME)/.cppuseful/ -std=c99
CC_FLAGS	= -Wall -ansi -pedantic -std=c99
CC_LINK		= -lpthread

# Filenames
EXEC		= out
ifndef SOURCES
SOURCES 	= $(shell find . -name '*.c' -type f)
endif
DIRS		= $(shell find . -type d -not -path "./obj*" -not -path ".")
OBJECTDIR   = ./obj
OBJECTS   	= $(addprefix $(OBJECTDIR)/, $(subst ./,, $(SOURCES:.c=.o)))

# all files
$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(EXEC) $(CC_LINK)

# pull in dependency info for *existing* .o files
-include $(OBJECTS:.o=.d)

# To obtain object files
$(OBJECTDIR)/%.o: %.c
	@mkdir -p $(@D)													# create the obj/ folder
	$(CC) -c $(CC_FLAGS) $< -o $@
	@$(eval DFILE = $(addsuffix .d, $(basename $@)))				# a dependency file
	@$(CC) -MM $(CC_FLAGS) $< > $(DFILE)							# create a dependencies file
	@$(eval TMPDFILE = $(addsuffix .d.tmp, $(basename $@)))			# a temp dependency file
	@mv -f $(DFILE) $(TMPDFILE)										# everything afterwards makes sure the folder paths are correct
	@sed -e 's|.*:|$*.o:|' < $(TMPDFILE) > $(DFILE)
	@sed -e 's/.*://' -e 's/\\$$//' < $(TMPDFILE) | fmt -1 | \
		sed -e 's/^ *//' -e 's/$$/:/' >> $(DFILE)
	@rm -f $(TMPDFILE)

# To remove generated files
.PHONY: clean
clean:
	-rm -fr $(OBJECTDIR)
	-rm -f $(EXECUTABLE)
