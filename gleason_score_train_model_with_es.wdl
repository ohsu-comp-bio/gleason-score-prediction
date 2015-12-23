task query_es {
  String server
  String query
  Array[String]? fields
  String outputDir
  
  command {
    /bin/query_es -s ${server} \
                  -q ${query} \
                  -f ${sep=' ' fields} \
                  -o ${outputDir} \
                  --output-json-fields
  }

  output {
    String metadata = "${outputDir}/es_query_results.txt"
    String individual_id = "${outputDir}/individual_id.json"
    String ccc_did = "${outputDir}/ccc_did.json"
  }

}


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
  call query_es

  call collect_features {
    input: featureFiles = query_es.ccc_did, fileIds = query_es.individual_id
  }
  
  call train_model {
    input: gene_expression_data_file = collect_features.featureMatrix, clinical_data_file = query_es.metadata
  }

}
