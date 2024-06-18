def validate_positive_int(value) -> int:
    if not isinstance(value, int):
        raise TypeError(f'value "{value} must be an int, got {type(value)}')
    if value < 0:
        raise ValueError(f'value "{value}" must be positive')
    
    return value
