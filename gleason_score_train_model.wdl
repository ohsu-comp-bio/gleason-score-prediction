task collect_features {
  Array[String]+ featureFiles
  Array[String]? fileIds
  String outputDir
  String outputFile
  
  command {
    /bin/collect_features --input-files ${sep=' ' featureFiles} \
                          --input-file-ids ${sep=' ' fileIds} \
                          --output-dir ${outputDir} \
                          --output-file ${outputFile}
  }

  output {
    String featureMatrix = "${outputDir}/${outputFile}"
  }

}

task train_model {
  String key
  String gene_expression_data_file
  String clinical_data_file

  command {
    KEY=${key} \
    CLINICAL_DATA=${clicical_data_file} \
    GENE_EXPRESSION_DATA=${gene_expression_data_file} \
    /bin/build_model
  }

  output {
    String html_report = "/out/model-diagnostics.html"
    String model_binary = "/out/model.pickle"
  }

}

workflow gleason_score_prediction {
  call collect_features 
  call train_model {
    input: gene_expression_file = collect_features.featureMatrix
  }
}
