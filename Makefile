SORUCES=$(wildcard *.ipynb)
TARGETS=$(SORUCES:.ipynb=.html)
NAME=$(shell basename $(PWD))
YEAR=$(shell date '+%Y')
REMOTE_PATH=/var/www/notes.pipal.in/$(YEAR)/$(NAME)
REMOTE_HOST=pipal@notes.pipal.in
REMOTE_LOCATION=$(REMOTE_HOST):$(REMOTE_PATH)
FILES=*.html *.csv images/

push: $(TARGETS)
	rsync -avz $(FILES) $(REMOTE_LOCATION)
	touch push

root:
	ssh $(REMOTE_HOST) mkdir -p $(REMOTE_PATH)

build: $(TARGETS)

%.html: %.ipynb
	jupyter nbconvert $<

clean:
	-rm $(TARGETS) push

loop:
	@while sleep 2; do make; done
