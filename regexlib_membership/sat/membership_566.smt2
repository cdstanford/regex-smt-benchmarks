;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(/(?:(?:(?:(?:[a-zA-Z0-9\\-_.!~*'():\@&=+\$,]+|(?:%[a-fA-F0-9][a-fA-F0-9]))*)(?:;(?:(?:[a-zA-Z0-9\\-_.!~*'():\@&=+\$,]+|(?:%[a-fA-F0-9][a-fA-F0-9]))*))*)(?:/(?:(?:(?:[a-zA-Z0-9\\-_.!~*'():\@&=+\$,]+|(?:%[a-fA-F0-9][a-fA-F0-9]))*)(?:;(?:(?:[a-zA-Z0-9\\-_.!~*'():\@&=+\$,]+|(?:%[a-fA-F0-9][a-fA-F0-9]))*))*))*))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "/"
(define-fun Witness1 () String (seq.++ "/" ""))
;witness2: "/%59;/;"
(define-fun Witness2 () String (seq.++ "/" (seq.++ "%" (seq.++ "5" (seq.++ "9" (seq.++ ";" (seq.++ "/" (seq.++ ";" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "/" "/")(re.++ (re.* (re.union (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ",")(re.union (re.range "." ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "\x5c" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.++ (re.range "%" "%")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))))(re.++ (re.* (re.++ (re.range ";" ";") (re.* (re.union (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ",")(re.union (re.range "." ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "\x5c" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.++ (re.range "%" "%")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))) (re.* (re.++ (re.range "/" "/")(re.++ (re.* (re.union (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ",")(re.union (re.range "." ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "\x5c" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.++ (re.range "%" "%")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.* (re.++ (re.range ";" ";") (re.* (re.union (re.+ (re.union (re.range "!" "!")(re.union (re.range "$" "$")(re.union (re.range "&" ",")(re.union (re.range "." ".")(re.union (re.range "0" ":")(re.union (re.range "=" "=")(re.union (re.range "@" "Z")(re.union (re.range "\x5c" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))))) (re.++ (re.range "%" "%")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
