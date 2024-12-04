function output = addImpulseNoise(input, Ps, Pp)
    input = im2double(input);
    salt_pepper = rand(size(input)); % Generate random values
    output = input;
    output(salt_pepper < Ps) = 1; % Salt
    output(salt_pepper > 1 - Pp) = 0; % Pepper
    output = im2uint8(output);
end
