# Build manticore search engine

See original https://github.com/manticoresoftware/manticoresearch/tree/master/dist/build_dockers

```bash
mkdir -p $HOME/manticore-build && \
cd $HOME/manticore-build && \
git clone https://github.com/denfm/manticore-build ./ && \
git clone https://github.com/manticoresoftware/manticoresearch.git ./source && \
make up && make logs && cd source/build/src && ls -la
```