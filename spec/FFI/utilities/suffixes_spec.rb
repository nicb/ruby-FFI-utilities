require 'spec_helper'

describe 'FFI::Utilities::Suffixes' do

  before :example do
    @l_sfxes = { 'linux' => '.so', 'darwin' => '.dylib', 'windows' => '.dll' }
    @o_sfxes = { 'linux' => '.o', 'darwin' => '.o', 'windows' => '.obj' }
  end

  context 'real world' do

    context 'libraries' do
  
      it 'should return the appropriate library suffix for any given platform', :obsolete => true do
        sfx = @l_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @l_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.library_suffix).to eq(sfx)
      end
  
    end
  
    context 'objects' do
  
      it 'should return the appropriate object suffix for any given platform' do
        sfx = @o_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @o_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.object_suffix).to eq(sfx)
      end
  
    end

  end

  context 'linux (fake)' do

    context 'libraries' do
  
      it 'should return the appropriate library suffix for any given platform', :obsolete => true do
        RUBY_PLATFORM = 'x86_64-linux'
        sfx = @l_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @l_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.library_suffix).to eq(sfx)
      end
  
    end
  
    context 'objects' do
  
      it 'should return the appropriate object suffix for any given platform' do
        RUBY_PLATFORM = 'x86_64-linux'
        sfx = @o_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @o_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.object_suffix).to eq(sfx)
      end
  
    end

  end

  context 'darwin (fake)' do

    context 'libraries' do
  
      it 'should return the appropriate library suffix for any given platform', :obsolete => true do
        RUBY_PLATFORM = 'x86_64-darwin11.0'
        sfx = @l_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @l_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.library_suffix).to eq(sfx)
      end
  
    end
  
    context 'objects' do
  
      it 'should return the appropriate object suffix for any given platform' do
        RUBY_PLATFORM = 'x86_64-darwin11.0'
        sfx = @o_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @o_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.object_suffix).to eq(sfx)
      end
  
    end

  end

  context 'windows (fake)' do

    context 'libraries' do
  
      it 'should return the appropriate library suffix for any given platform', :obsolete => true do
        RUBY_PLATFORM = 'x86_64-windows7'
        sfx = @l_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @l_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.library_suffix).to eq(sfx)
      end
  
    end
  
    context 'objects' do
  
      it 'should return the appropriate object suffix for any given platform' do
        RUBY_PLATFORM = 'x86_64-windows7'
        sfx = @o_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @o_sfxes[p.to_s] }}.compact.first
        expect(FFI::Utilities.object_suffix).to eq(sfx)
      end
  
    end

  end

  context 'unknown system (fake)' do

    context 'libraries' do
  
      it 'should return the appropriate library suffix for any given platform', :obsolete => true do
        RUBY_PLATFORM = 'x86_64-unknown'
        sfx = @l_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @l_sfxes[p.to_s] }}.compact.first
        expect{ FFI::Utilities.library_suffix }.to raise_error(FFI::Utilities::UnknownPlatform, "library_suffix: unknown platform #{RUBY_PLATFORM}")
      end
  
    end
  
    context 'objects' do
  
      it 'should return the appropriate object suffix for any given platform' do
        RUBY_PLATFORM = 'x86_64-unknown'
        sfx = @o_sfxes.keys.map { |os| RUBY_PLATFORM.match(os) { |p| @o_sfxes[p.to_s] }}.compact.first
        expect{ FFI::Utilities.object_suffix }.to raise_error(FFI::Utilities::UnknownPlatform, "object_suffix: unknown platform #{RUBY_PLATFORM}")
      end
  
    end

  end

end
