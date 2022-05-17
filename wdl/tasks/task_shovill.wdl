version 1.0

task shovill_task {
  meta {
    # task metadata
    description: "shovill task file"
  }
  input {
    # input
    File read1
    File read2
    Int? depth = 150
    String? gsize = "''"
    # output
    Int? minlen = 0
    Int? mincov = 2
    # assembler
    String? assembler = "spades"
    String? options = "''"
    # resources
    Int? cpus = 4
    Int? ram = 8
    String docker = "staphb/shovill:1.1.0"
  }
  command <<<
    shovill --outdir out --R1 ~{read1} --R2 ~{read2} --depth ~{depth} --gsize ~{gsize} \
    --minlen ~{minlen} --mincov ~{mincov} \
    --cpus ~{cpus} --ram ~{ram} \
    --assembler ~{assembler} --opts ~{options}    
  >>>
  output {
    # task outputs
    File contigs = "out/contigs.fa"
  }
  runtime {
    # runtime environment
    docker: "~{docker}"
    memory: "~{ram} GB"
    cpu: "~{cpus}"
    disks: "local-disk 50 SSD"
    preemptible: 0
  }
}
