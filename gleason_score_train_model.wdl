task collect_features {
  Array[String]+ featureFiles
  Array[String]? fileIds
  String outputFile
  
  command {
    /bin/collect_features --input-files ${sep=' ' featureFiles} \
                          --input-file-ids ${sep=' ' fileIds} \
                          --output-file ${outputFile}
  }

  output {
    String featureMatrix = "${outputFile}"
  }

  runtime {
    docker: "gleason_score_train_model"
  }
}

task train_model {
  String gene_expression_data_file
  String clinical_data_file

  command {
    CLINICAL_DATA=${clicical_data_file} \
    GENE_EXPRESSOIN_DATA=${gene_expression_data_file} \
    /bin/build_model
  }

  output {
    String html_report = "/out/model-diagnostics.html"
    String model_binary = "/out/model.pickle"
  }

  runtime {
    docker: "gleason_score_train_model"
  }
}

workflow gleason_score_prediction {
  call collect_features
  call train_model
}
