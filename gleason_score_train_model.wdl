task query_elasticsearch {
     String server
     String query
     String outputIds
     String outputFile

}


task collect_features {
    Array[String]+ featureFiles
    Array[String]? fileIds
    String outputFile
    
    command {
    collect_features.py --input-files ${sep=' ' featureFiles} \
                        ${"--input-file_ids " + fileIds} \
                        --output-file ${outputFile}
    }

    output {
        String featureMatrix = "${outputFile}"
    }
}


task train_model {
    String gene_expression_data_file
    String clinical_data_file

    command {
    clinical_data=${clinical_data_file} \
    gene_expression_data=${gene_expression_data_file} \
    jupyter-nbconvert --to html --execute \
    ${notebook}
    }

    output {
    String html_report "${notebook}.html"
    String model_binary "pipeline.pickle"
    }

    runtime {
        tool: ""
        strategy: ""
    }
}


workflow gleason_score_prediction {
    call train_model
}
