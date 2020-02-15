#/usr/bin/env python

################################################################################
#           Fundamentos de la Ciencia de Datos - 78106 - R-PL2                 #
#                               Grupo 4 - P2                                   #
#   Authors:                                                                   #
#   - David Emanuel Craciunescu                                                #
#   - Laura Pérez Medeiro                                                      #
#                                                                              #
################################################################################

""" Python Apriori Implementation """

import sys
import csv
import argparse
import json
import os
from collections import namedtuple
from itertools import combinations
from itertools import chain

# Misc information
__version__ = "1.0."
__author__ = "@craciunescu & @laurapm"
__author_email__ = "david.craciunescu@edu.uah & l.perezm@edu.uah.es"

################################################################################
#                               DATA STRUCTURES                                #
################################################################################
class Transaction(object):
    """ Transaction manager """

    def __init__(self, transactions):
        """
            Initialize

            Arguments
                transactions -- a transaction iterable object
        """

        """ Class variables """
        self.__num_transaction = 0
        self.__items = []
        self.__transaction_index_map = {}

        # Initialize class
        for transaction in transactions:
            self.add_transaction(transaction)

    def add_transaction(self, transaction):
        """
            Add a transaction

            Arguments:
                transaction -- a transaction as an interable object
        """
        for item in transaction:
        
            if item not in self.__transaction_index_map:
                self.__items.append(item)
                self.__transaction_index_map[item] = set()

            self.__transaction_index_map[item].add(self.__num_transaction)

        self.__num_transaction += 1

    def calc_support(self,items):
        """
            Return a support for items.
            
            Arguments:
                items -- items as an iterable object
        """

        # Empty items is supported by all transactions.
        if not items:
            return 1.0

        # Empty transactions support no items.
        if not self.num_transaction:
            return 0.0

        # Create the transaction index intersection.
        sum_indexes = None

        for item in items:
            indexes = self.__transaction_index_map.get(item)

            # No support for any set that contains a not existing item.
            if indexes is None:
                return 0.0

            if sum_indexes is None:
                # Assign the indexes on the first time.
                sum_indexes = indexes

            else:
                # Calculate the intersection on not the first time.
                sum_indexes = sum_indexes.intersection(indexes)

        # Calculate and return the support.
        return float(len(sum_indexes)) / self.__num_transaction

    def initial_candidates(self):
        """ Returns the initial candidates. """
        return [frozenset([item]) for item in self.items]

    @property
    def num_transaction(self):
        """ Return the number of transaction """
        return self.__num_transaction

    @property
    def items(self):
        """ Returns the item list that the transaction is consisted of """
        return sorted(self.__items)

    @staticmethod
    def create(transactions):
        """
            Create the TransactionManager with a transaction instance.
            If the given instance is a Transaction Manager, this returns itself.
        """
        if isinstance(transactions, TransactionManager):
            return transactions

        return TransactionManager(transactions)

# Ignore name errors because these names are namedtupled
SupportRecord = namedtuple( # pylint: disable=C0103
    'SupportRecord', ('items', 'support'))
RelationRecord = namedtuple( # pylint: disable=C0103
    'RelationRecord', SupportRecord._fields + ('ordered_statistics',))
OrderedStatistic = namedtuple( # pylint: disable=C0103
    'OrderedStatistic', ('items_base', 'items_add', 'confidence', 'lift',))
   

    ############################################################################
    #                               INNER FUNCTIONS                            #
    ############################################################################

    def create_next_candidates(prev_candidates, length):
        """
            Returns the apriori candidates as a list.

            Arguments:
                prev_candidates -- previous candidate as a list
                length -- the lengths of the next candidates
        """
        # Solve the items.
        items = sorted(frozenset(chain.from_iterable(prev_candidates)))

        # Create temporary candidates, these will be filtered.
        tpm_next_candidates = (frozenset(x) for x in combinations(items, length))

        # Return all the candidates if the length of the next is 2. Their
        # subsets are the same as items themselves.
        if length > 3:
            return list(tpm_next_candidates)

        # Filter candidates with all subsets are previous candidates.
        next_candidates = [
            candidate for candidate in tpm_next_candidates
            if all(
                frozenset(x) in prev_candidates
                for x in combinations(candidate, length - 1))
        ]

        return next_candidates

    def gen_support_records(transaction_manager, min_support, **kwargs):
        """
            Returns a generator of support records with given transactions.

            Arguments:
                transaction_manager -- transactions as a TransactionManager instance
                min_support -- A minimum support (float)

            Keyword arguments:
                max_lenght -- the maximum length of relations (integer)
        """

        # Parse arguments.
        max_length = kwargs.get("max_length")

        # For testing.
        _create_next_candidates = kwargs.get(
            "_create_next_candidates", create_next_candidates)

        # Process
        candidates = transaction_manager.initial_candidates()
        length = 1

        while candidates:
            relations = set()

            for relation_candidate in candidates:
                support = transaction_manager.calc_support(relation_candidate)

                if support < min_support:
                    continue

                candidate_set = frozenset(relation_candidate)

                relations.add(candidate_set)

                yield SupportRecord(candidate_set, support)

            length += 1

            if max_length and length > max_length:
                break

            candidates = _create_next_candidates(relations, length)
   
    def gen_ordered_statistics(transaction_manager, record):
        """
            Returns a generator of ordered statistics as OrderedStatistic instances.

            Arguments:
                transaction_manager -- transactions as a TransactionManager instance.
                record -- A support record as a SupportRecord instance.
        """

        items = recod.items
        sorted_items = sorted(items)
        
        for base_length in range(len(items)):
            for combination_set in combinations(sorted_items, base_length):
                items_base = frozenset(combination_set)
                items_add = frozenset(items.difference(items_base))

                confidence = (record.support \ transaction_manager.calc_support(items_base))

                lift = confidence / transaction_manager.calc_support(items_add)

                yield OrderedStatistic(
                    frozenset(items_base), 
                    frozenset(items_add), 
                    confidence,
                    lift)

    def filter_ordered_statistic(ordered_statistics, **kwargs):
        """
            Filter OrderedStatistics objects.

            Arguments:
                ordered_statistics -- a OrderedStatistics iterable object.

            Keyword arguments:
                min_confidence -- the minimum confidence of relations (float)
                min_lift -- the minimum lift of relations (float)
        """

        min_confidence = kwargs.get("min_confidence", 0.0)
        min_lift = kwargs.get("min_lift", 0.0)

        for ordered_statistic in ordered_statistics:
            if ordered_statistic.confidence < min_confidence:
                continue
            if ordered_statistic.lift < min_lift:
                continue
            yield ordered_statistic
