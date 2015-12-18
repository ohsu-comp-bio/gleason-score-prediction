#!/usr/bin/env python

import argparse
import os
import pandas as pd


def collectArgs():
    descr = 'Collect / Aggregate Feature Files'
    parser = argparse.ArgumentParser(
        description=descr,
        formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument("-i", "--input-files", dest="files", nargs="+",
                        required=True,
                        help="tab separated text files where column 1 contains \
                        the gene id and column 2 contains raw or normalized \
                        read counts")
    parser.add_argument("-I", "--input-file-ids", dest="file_ids", nargs="+",
                        required=False,
                        help="IDs to use as column names in merged matrix")
    parser.add_argument("-o", "--output-file", dest="output_file",
                        required=True,
                        help="tab separated values will be written to this \
                        file")
    return parser


def collectFeatures(files, ids):
    featureMatrix = pd.DataFrame()
    for i in range(0, len(files)):
        if ids[i] is not None:
            file_basename = ids[i]
        else:
            file_basename = os.path.basename(files[i])
        features = pd.read_csv(files[i],
                               sep="\t",
                               index_col=0)
        features.columns = ['gene_id', file_basename]
        try:
            featureMatrix = pd.merge(featureMatrix, features, how="outer",
                                     on="gene_id")
        except IndexError:
            featureMatrix = features
    return featureMatrix


if __name__ == '__main__':
    parser = collectArgs()
    args = parser.parse_args()
    if args.file_ids is not None:
        if len(args.file_ids) != len(args.files):
            print "The number of input files must be the same as the number of \
            IDs supplied."
            exit(1)
    featureMatrix = collectFeatures(args.files, args.file_ids)
    featureMatrix.to_csv(args.output_file, sep="\t", encoding="acsii",
                         header=True, index=True, index_label="gene_id")
