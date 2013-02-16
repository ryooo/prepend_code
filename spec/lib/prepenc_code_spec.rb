# -*- coding: utf-8 -*-
require 'rubygems'
require 'rspec'
require 'prepend_code'

describe PrependCode::Application do
  context 'prepend_on_file!' do
    context 'file first line is different from prepend_context' do
      before {
        @file_path = './spec/test/test.rb'
        output = File.new(@file_path, "w")
        lines = ["original_1\n", "original_2\n"]
        lines.each { |line| output.write line }
        output.close
        @result = PrependCode::Application.prepend_on_file!(@file_path, 'prepend_context')
      }
      describe 'return ' do
        subject { @result }
        it { should be_true }
      end
      
      describe 'file lines' do
        subject {
          f = File.open(@file_path, "r+")
          lines = f.readlines
          f.close
          lines
        }
        it { should == ["prepend_context\n", "original_1\n", "original_2\n"] }
      end
    end
    
    context 'file first line is same with prepend_context' do
      before {
        @file_path = './spec/test/test.rb'
        output = File.new(@file_path, "w")
        lines = ["prepend_context\n", "original_1\n", "original_2\n"]
        lines.each { |line| output.write line }
        output.close
        @result = PrependCode::Application.prepend_on_file!(@file_path, 'prepend_context')
      }
      describe 'return ' do
        subject { @result }
        it { should be_false }
      end
      
      describe 'file lines' do
        subject {
          f = File.open(@file_path, "r+")
          lines = f.readlines
          f.close
          lines
        }
        it { should == ["prepend_context\n", "original_1\n", "original_2\n"] }
      end
    end
  end
  
  context 'find_file_paths' do
    context 'search sub directory too, and unmatch if extension is wrong.' do
      before {
        @file_path1 = './spec/test/test.rb'
        output = File.new(@file_path1, "w")
        output.close
        @file_path2 = './spec/test/sub/test2.rb'
        output = File.new(@file_path2, "w")
        output.close
        @file_path3 = './spec/test/sub/test3.txt'
        output = File.new(@file_path3, "w")
        output.close
        @result = PrependCode::Application.find_file_paths('./spec/test', '.rb')
      }
      describe 'return ' do
        subject { @result }
        it { should == [@file_path2, @file_path1] }
      end
    end
  end
  
  context 'run!' do
    context 'search sub directory too, and unmatch if extension is wrong.' do
      before {
        @file_path1 = './spec/test/test.rb'
        output = File.new(@file_path1, "w")
        output.close
        @file_path2 = './spec/test/sub/test2.rb'
        output = File.new(@file_path2, "w")
        output.close
        @file_path3 = './spec/test/sub/test3.txt'
        output = File.new(@file_path3, "w")
        output.close
        @result = PrependCode::Application.find_file_paths('./spec/test', '.rb')
      }
      describe 'return ' do
        subject { @result }
        it { should == [@file_path2, @file_path1] }
      end
    end
  end
end