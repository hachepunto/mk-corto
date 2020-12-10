<config.mk

results/%.regulon.RData:	data/%.RDS
	mkdir -p `dirname $target`
	bin/corto-network.R \
		-i $prereq \
		-l $TFS \
		-b $BOOTSTRAPS \
		-p $PVALUE \
		-t $THREADS \
		-o $target'.build' \
	&& mv $target'.build' $target
