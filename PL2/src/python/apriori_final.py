#/usr/bin/env python

################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL2                 #
#                               Grupo 4 - P2                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

""" Simple Python Apriori Implementation. """

# Relevant information.
__author__ = "@craciunescu & @laurapm"
__version__ = "1.0"

# Imports
import argparse
import json
import os
import sys
import csv

from collections import namedtuple
from itertools import combinations
from itertools import chain

################################################################################
#                               DATA STRUCTURES                                #
################################################################################
class Operation(object):
    """ 
        Operation class.
        > This data structure controls the basic functioning and behavior of the
        > operations in the Apriori algorithm
    """

    def __init__(self, operations):
        """
            Constructor of the Operation class.

            args ->
                operations -> an operation as an iterable object.
        """

        """ Class variables """
        self.__items = []
        self.__operation_index_map = {}
        self.__num_operation = 0

        # Initialize
        for operation in operations:
            self.add_operation(operation)

    def add_operation(self, operation):
        """
            Create a new operation.

            args ->
                operation -> a operation as an interable object
        """
        for element in operation:
            
            if element is not in self.__operation_index_map:
                self.__items.append(element)
                self.__operation_index_map[element] = set()

            self.__operation_index_map[element].add(self.__num_operation)

        self.__num_operation += 1

    def get_support(self, elements):
        """
            Calculate the support for the given elements.

            args ->
                elements -> elements as an interable object.
        """
        # Special cases

        ## Empty elements are supported by everything
        if not elements:
            return 1.0

        ## Empty operations support no elements
        if not self.num_transaction:
            return 0.0

        # Expected cases

        ## Create operation index intersection.
        sum_indexes = None

        for element in elements:
            indexes = self.__operation_index_map.get(element)

            # No support for sets with elements that do not exist
            if indexes is None:
                return 0.0

            # Assign index the first time
            if sum_indexes is None:
                sum_indexes = indexes
            else:
                sum_indexes = sum_indexes.intersection(indexes)

        # Calculate support
        return float(len(sum_indexes)) / self.__num_operations
            
                
