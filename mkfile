<config.mk

results/%.regulon.RDS:	data/%.RDS
	mkdir -p `dirname $target`
	bin/corto-network.R \
		-i $prereq \
		-l $TFS \
		-b $BOOTSTRAPS \
		-p $PVALUE \
		-t $THREADS \
		-o $target'.build' \
	&& mv $target'.build' $target
