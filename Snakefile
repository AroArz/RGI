# vim: syntax=python expandtab tabstop=4
# RGI
# Aron Arzoomand 25/3 2020

SAMPLES = glob_wildcards("input/{sample}.snp.fasta").sample
print(SAMPLES)

rule all:
    input:
            expand("output/{sample}.rgi.output", sample=SAMPLES)

rule RGI:
    input:
            SNPs="input/{sample}.snp.fasta"
    output:
            confirmed_snps="output/{sample}.rgi.output"
    conda:
            "envs/rgi.yml"
    threads:
            cluster_config["RGI"]["n"] if "RGI" in cluster_config else 8
    shell:
            """
            rgi main \
            --input_sequence {input.SNPs} \
            --output_file {output.confirmed_snps} \
            --input_type contig \
            --low_quality \
            --clean
            """

