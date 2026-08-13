from graphviz import Source

# read the dag
with open('./tmp/CFG/_Z8spmv_jdsPfPKfPKiS3_S1_S3_i_LS.dot', 'r') as file:
    dag = file.read()

# create a source object and render image
src = Source(dag)
src.render('output.gv', view=True)
