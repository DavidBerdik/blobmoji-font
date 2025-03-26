FROM ubuntu:latest

COPY svg ./svg
COPY third_party/region-flags/svg ./flags
COPY emoji_aliases.txt NotoColorEmoji.tmpl.ttx.tmpl Blobmoji.gpl requirements.txt ./
COPY AUTHORS_Noto CONTRIBUTORS_Noto CONTRIBUTORS_Blob.md CHANGES.md MODIFIED.md LICENSE ./
COPY emoji_builder.zip ./

RUN apt update && apt install -y \
	python3 \
	python-is-python3 \
	python3-pip \
	unzip \
	fonts-comic-neue \
	&& apt-get clean && rm -f /var/lib/apt/lists/*_* \
	&& pip install -r /requirements.txt --no-cache-dir --break-system-packages \
	&& unzip emoji_builder.zip \
	&& chmod +x emoji_builder

CMD ./emoji_builder -b /build -o Blobmoji.ttf -O /output --flags ./flags blobmoji -w -a ./emoji_aliases.txt --ttx-tmpl ./NotoColorEmoji.tmpl.ttx.tmpl --palette ./Blobmoji.gpl && \
	mv /output/Blobmoji_win.ttf /output/BlobmojiWindows.ttf
