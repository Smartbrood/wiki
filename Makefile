
WORK_DIR=$(shell pwd)
UID=1001
JEKYLL_VERSION=3.8

build:
	docker run --rm \
  		--volume="$(WORK_DIR)/docs:/srv/jekyll" \
		--volume="$(WORK_DIR)/bundle:/usr/local/bundle" \
		-e JEKYLL_UID=$(UID) \
		-e JEKYLL_GID=$(UID) \
  		-it jekyll/jekyll:$(JEKYLL_VERSION) \
  		jekyll build

serve:
	docker run --rm \
  		--volume="$(WORK_DIR)/docs:/srv/jekyll" \
		--volume="$(WORK_DIR)/bundle:/usr/local/bundle" \
		-e JEKYLL_UID=$(UID) \
		-e JEKYLL_GID=$(UID) \
		-p 4000:4000 \
  		-it jekyll/jekyll:$(JEKYLL_VERSION) \
  		jekyll serve

create:
	docker run --rm \
  		--volume="$(WORK_DIR)/docs:/srv/jekyll" \
		--volume="$(WORK_DIR)/bundle:/usr/local/bundle" \
		-e JEKYLL_UID=$(UID) \
		-e JEKYLL_GID=$(UID) \
  		-it jekyll/jekyll:$(JEKYLL_VERSION) \
  		jekyll new .

update:
	docker run --rm \
  		--volume="$(WORK_DIR)/docs:/srv/jekyll" \
		--volume="$(WORK_DIR)/bundle:/usr/local/bundle" \
		-e JEKYLL_UID=$(UID) \
		-e JEKYLL_GID=$(UID) \
  		-it jekyll/jekyll:$(JEKYLL_VERSION) \
  		bundle update