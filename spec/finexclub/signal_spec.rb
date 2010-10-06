require File.dirname(__FILE__) + '/../spec_helper'

describe 'Finexclub::Signal' do
  before do
    @core = mock_core 
    @signal = Finexclub::Signal.new(@core)
  end

  describe 'self.build' do
    before do
      class Finexclub::Signals::Foo < Finexclub::Signal
        field :foo, :integer
      end
    end

    describe 'self.handler_for' do
      it 'should return valid signal class' do
        Finexclub::Signal.handler_for(:foo).should == Finexclub::Signals::Foo
      end

      it 'should raise with unknown handler' do
        lambda {
          Finexclub::Signal.handler_for(:bar)
        }.should.raise(NameError)
      end
    end

    it 'should create new signal instance and initialize it with params' do
      Finexclub::Signals::Foo.should.receive(:new).with(@core).and_return(sig = mock('signal'))
      params = mock('params')
      sig.should.receive(:build).with(params)

      Finexclub::Signal.build(@core, :foo, params).should == sig
    end
  end

end

