require "pp"
require 'open-uri'
require 'pdf-reader'
require 'date'
require 'regex_mapping_helper'

class StatementController < ApplicationController
  after_action :delete_uploaded_txns, only: [:uploaded]

  UPLOADED_TXNS = []
  CHOSEN_WALLET = []

  def new
    @wallets = current_user.wallets
  end

  def create
    @uploaded = []

    # pass a main wallet id, that they can select from

    pdf = params[:file].tempfile
    io = open(pdf)
    reader = PDF::Reader.new(io)

    CHOSEN_WALLET << params[:wallet]

    reader.pages.each do |page|
      text = page.text
      array = text.split("\n")
      regex3 = /\s+(\d{2}\s{1}\D{3})\s+(.+)\s{1}(\d{2}\s{1}\D{3})(\s+\W\s+)(\d{1,}.\d{2})/

      array.each do |line|
        if line.match(regex3)
          match = line.match(regex3)
          RegexMappingHelper::REGEX_MAPPING.each do |regex, category_id|
            if match[2].match(regex)
              newTxn = Transaction.new(description: match[2].to_s,
                                       txn_type: "Expense",
                                       user_id: current_user.id,
                                       amount: match[5],
                                       category_id: category_id,
                                       date: Date.parse("#{match[3]} #{Date.today.year}"),
                                       main_wallet_id: params[:wallet])  # main wallet here should be taken from above field, user choose wallet
              newTxn.save
              UPLOADED_TXNS << newTxn
              break
              # category_id = "transport"
            end
            # newTxn = Transaction.new(description: match[2].to_s,
            #               txn_type: "Expense",
            #               user_id: current_user.id,
            #               amount: match[5],
            #               category_id: 9, # category id
            #               date: Date.parse("#{match[3]} #{Date.today.year}"),
            #               main_wallet_id: 1)  # main wallet here should be taken from above field, user choose wallet
            # newTxn.save
            # UPLOADED_TXNS << newTxn
            # break
          end
        end
      end
    end

    redirect_to statement_uploaded_path
  end

  def uploaded
    @array = UPLOADED_TXNS
    @wallet_id = CHOSEN_WALLET
  end

  private

  def delete_uploaded_txns
    UPLOADED_TXNS.clear
  end
end
