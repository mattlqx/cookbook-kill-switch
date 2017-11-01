#
# Cookbook:: kill-switch
# Spec:: default
#
# Copyright:: 2017, Matt Kulka

require 'spec_helper'

class FakeException < RuntimeError; end

describe 'kill-switch::default' do
  let(:chef_run) do
    c = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    c
  end

  let(:converge) { chef_run.converge('recipe[kill-switch::default]', 'recipe[kill-switch-test::default]') }

  before do
    allow(Chef::Application).to receive(:fatal!).and_raise(SystemExit)
  end

  context 'When all attributes are default, on an Ubuntu 16.04' do
    it 'converges successfully' do
      converge
      expect { converge }.to_not raise_error
      expect(converge).to include_recipe('kill-switch-test::default')
      expect(converge).to write_log('This is a test recipe')
    end
  end

  context 'When kill switch is engaged through attribute' do
    it 'exits noisily' do
      chef_run.node.normal['kill_switch']['engage'] = true
      expect { converge }.to raise_error(SystemExit)
    end

    it 'exits normally before running other recipes' do
      chef_run.node.normal['kill_switch']['engage'] = true
      chef_run.node.normal['kill_switch']['normal_exit'] = true

      expect { converge }.to_not raise_error
      expect(converge).to_not include_recipe('kill-switch-test::default')
    end
  end

  context 'When kill switch is engaged through touch file' do
    before do
      allow(File).to receive(:exist?).and_call_original
      allow(File).to receive(:exist?).with('/.kill_chef').and_return(true)
    end

    it 'exits noisily' do
      expect { converge }.to raise_error(SystemExit)
    end

    it 'exits normally before running other recipes' do
      chef_run.node.normal['kill_switch']['normal_exit'] = true

      expect { converge }.to_not raise_error
      expect(converge).to_not include_recipe('kill-switch-test::default')
    end
  end
end
