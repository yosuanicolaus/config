import sys

# Output of the following bash command (last updated [260222])
# for d in 11 12 13 14; do find "./$d" -mindepth 2 -type f -name "*.pdf" ! -path "*/figures/*" | sort; done
find_result = """
./11/01/Starting points.pdf
./11/02/Mathematical models.pdf
./11/03/Numbers.pdf
./11/04/Statistical summaries.pdf
./11/05/Algebra.pdf
./11/06/Graphs.pdf
./11/07/Equations and inequalities.pdf
./11/08/Geometry.pdf
./11/09/Expanding algebra.pdf
./11/10/Quadratics.pdf
./11/11/Statistical pictures.pdf
./11/12/Trigonometry.pdf
./11/13/Exponentials.pdf
./11/14/Mathematics everywhere.pdf
./12/01/Looking for patterns.pdf
./12/02/Prices.pdf
./12/03/Earnings.pdf
./12/04/Surveys.pdf
./12/05/Relationships.pdf
./12/06/Truancy.pdf
./12/07/Factors affecting reading.pdf
./12/08/Teaching how to read.pdf
./12/09/Comparing schools.pdf
./12/10/Experiments.pdf
./12/11/Testing new drugs.pdf
./12/12/Review.pdf
./13/01/Algebra.pdf
./13/02/Graphs and equations.pdf
./13/03/Functions.pdf
./13/04/Trigonometry.pdf
./13/05/Coordinate geometry and vectors.pdf
./13/06/Differentiation.pdf
./13/07/Differentiation methods and integration.pdf
./13/08/Integration methods.pdf
./13/09/Matrices.pdf
./13/10/Sequences and series.pdf
./13/11/Taylor polynomials.pdf
./13/12/Complex numbers.pdf
./14/01/Key Techniques.pdf
./14/02/Mathematical Typesetting.pdf
./14/03/Number Theory.pdf
./14/04/Conics.pdf
./14/05/Statics.pdf
./14/06/Geometric Transformations.pdf
./14/07/Topics in Calculus.pdf
./14/08/Differential Equations.pdf
./14/09/Mathematical Language and Proof.pdf
./14/10/Dynamics.pdf
./14/11/Eigenvalues and Eigenvectors.pdf
./14/12/Combinatorics.pdf
""".strip()

mod_codes = {
    "11": "MU123",
    "12": "M140",
    "13": "MST124",
    "14": "MST125",
}

ou_modules = {}

for file_path in find_result.split("\n"):
    file_path = file_path[2:]
    mod_num, unit_num, file_name = file_path.split("/")
    ou_modules.setdefault(mod_num, {})
    ou_modules[mod_num][unit_num] = file_name[:-4]  # removes the "*.pdf"


def generate_ou_module(trigger: str):
    """
    ex trigger: "1101", "1309"
    """
    mod_num = trigger[:2]
    unit_num = trigger[-2:]

    try:
        mod_code = mod_codes[mod_num]
        unit_name = ou_modules[mod_num][unit_num]
        return f"{mod_code} / u.{unit_num} / {unit_name}"
    except KeyError:
        return f"OU Module-Unit '{mod_num}-{unit_num}' does not exist"


if __name__ == "__main__":
    result = generate_ou_module(sys.argv[1])
    print(result)
