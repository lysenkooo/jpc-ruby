class FakeSocket
  attr_reader :data

  def send(data)
    @data = data
  end
end
