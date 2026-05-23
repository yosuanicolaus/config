import sys

# Output of the following bash command (last updated [260222])
# for d in 123 124 125 140 208 224 248; do find "./$d" -mindepth 2 -type f -name "*.pdf" ! -path "*/figures/*" | sort; done
find_result = """
./123/01/Starting points.pdf
./123/02/Mathematical models.pdf
./123/03/Numbers.pdf
./123/04/Statistical summaries.pdf
./123/05/Algebra.pdf
./123/06/Graphs.pdf
./123/07/Equations and inequalities.pdf
./123/08/Geometry.pdf
./123/09/Expanding algebra.pdf
./123/10/Quadratics.pdf
./123/11/Statistical pictures.pdf
./123/12/Trigonometry.pdf
./123/13/Exponentials.pdf
./123/14/Mathematics everywhere.pdf
./124/01/Algebra.pdf
./124/02/Graphs and equations.pdf
./124/03/Functions.pdf
./124/04/Trigonometry.pdf
./124/05/Coordinate geometry and vectors.pdf
./124/06/Differentiation.pdf
./124/07/Differentiation methods and integration.pdf
./124/08/Integration methods.pdf
./124/09/Matrices.pdf
./124/10/Sequences and series.pdf
./124/11/Taylor polynomials.pdf
./124/12/Complex numbers.pdf
./124/figures13/tma3-7.pdf
./125/01/Key Techniques.pdf
./125/02/Mathematical Typesetting.pdf
./125/03/Number Theory.pdf
./125/04/Conics.pdf
./125/05/Statics.pdf
./125/06/Geometric Transformations.pdf
./125/07/Topics in Calculus.pdf
./125/08/Differential Equations.pdf
./125/09/Mathematical Language and Proof.pdf
./125/10/Dynamics.pdf
./125/11/Eigenvalues and Eigenvectors.pdf
./125/12/Combinatorics.pdf
./140/01/Looking for patterns.pdf
./140/02/Prices.pdf
./140/03/Earnings.pdf
./140/04/Surveys.pdf
./140/05/Relationships.pdf
./140/06/Truancy.pdf
./140/07/Factors affecting reading.pdf
./140/08/Teaching how to read.pdf
./140/09/Comparing schools.pdf
./140/10/Experiments.pdf
./140/11/Testing new drugs.pdf
./140/12/Review.pdf
""".strip()

mod_codes = {
    "123": "MU123",
    "140": "M140",
    "124": "MST124",
    "125": "MST125",
}

ou_modules = {}

for file_path in find_result.split("\n"):
    file_path = file_path[2:]
    mod_num, unit_num, file_name = file_path.split("/")
    ou_modules.setdefault(mod_num, {})
    ou_modules[mod_num][unit_num] = file_name[:-4]  # removes the "*.pdf"


def generate_ou_module(trigger: str):
    """
    ex trigger: "12301", "10409"
    """
    mod_num = trigger[:3]
    unit_num = trigger[-2:]

    try:
        mod_code = mod_codes[mod_num]
        unit_name = ou_modules[mod_num][unit_num]
        return f"[{mod_code}] u.{unit_num} — {unit_name}"
    except KeyError:
        return f"OU Module-Unit '[{mod_num}] u.{unit_num}' does not exist"


if __name__ == "__main__":
    result = generate_ou_module(sys.argv[1])
    print(result)
