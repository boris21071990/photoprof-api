describe SortOrderBuilder do
  describe ".call" do
    let(:sort) { "id,-created_at,updated_at" }
    let(:allowed_sort_fields) { [:id, :created_at] }
    let(:default_order) { :id }

    subject { described_class.call(sort, allowed_sort_fields, default_order) }

    it "returns order" do
      is_expected.to eq({ "id" => :asc, "created_at" => :desc })
    end

    context "with not allowed sort fields" do
      let(:sort) { "test" }

      it "returns default order" do
        is_expected.to eq(default_order)
      end
    end
  end
end
