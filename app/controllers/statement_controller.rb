require "pp"
require 'open-uri'
require 'pdf-reader'
require 'date'

class StatementController < ApplicationController
  UPLOADED_TXNS = []
  def new
  end

  def create
    @uploaded = []

    # pass a main wallet id, that they can select from

    pdf = params[:file].tempfile
    io = open(pdf)
    reader = PDF::Reader.new(io)

    reader.pages.each do |page|
      text = page.text
      array = text.split("\n")

      # example = " 10 Feb           BUS/MRT 228880949     SINGAPORE     SG 05 FEB                $                2.76"
      regex3 = /\s+(\d{2}\s{1}\D{3})\s+(.+)\s{1}(\d{2}\s{1}\D{3})(\s+\W\s+)(\d{1,}.\d{2})/
      # if example.match(regex3)
      #   match = example.match(regex3)
      #   newTxn = Transaction.new(description: match[2].to_s,
      #                         txn_type: "Expense",
      #                         user_id: current_user.id,
      #                         amount: match[5],
      #                         category_id: 3,
      #                         date: Date.parse("#{match[3]} #{Date.today.year}"),
      #                         main_wallet_id: 1)
      #                         # main wallet here should be taken from above
      #   newTxn.save
      #   UPLOADED_TXNS << newTxn
      # else
      # end

      array.each do |line|
        if line.match(regex3)
          match = line.match(regex3)
          newTxn = Transaction.new(description: match[2].to_s,
                      txn_type: "Expense",
                      user_id: current_user.id,
                      amount: match[5],
                      category_id: 3,
                      date: Date.parse("#{match[3]} #{Date.today.year}"),
                      main_wallet_id: 1)
                      # main wallet here should be taken from above
          newTxn.save
          UPLOADED_TXNS << newTxn
        else
        end
      end
    end

    redirect_to statement_uploaded_path
  end

  def uploaded
    @array = UPLOADED_TXNS
  end
end
