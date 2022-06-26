# Basic tests
def test_always_passes():
    assert True


def test_always_fail():
    assert False

# Best Test Practices
# Testing absolute value function


def test_abs_for_a_negative_number():
    # Arrange
    negative = -5

    # Act
    answer = abs(negative)

    # Assert
    assert answer == 5
