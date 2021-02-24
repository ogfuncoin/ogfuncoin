// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef OGFUNCOIN_QT_OGFUNCOINADDRESSVALIDATOR_H
#define OGFUNCOIN_QT_OGFUNCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class ogfuncoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ogfuncoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** ogfuncoin address widget validator, checks for a valid ogfuncoin address.
 */
class ogfuncoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit ogfuncoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // OGFUNCOIN_QT_OGFUNCOINADDRESSVALIDATOR_H
