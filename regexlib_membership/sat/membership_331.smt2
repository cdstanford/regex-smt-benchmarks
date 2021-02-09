;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([a-zA-Z1-9]*)\.(((a|A)(s|S)(p|P)(x|X))|((h|H)(T|t)(m|M)(l|L))|((h|H)(t|T)(M|m))|((a|A)(s|S)(p|P))|((t|T)(x|X)(T|x))|((m|M)(S|s)(P|p)(x|X))|((g|G)(i|I)(F|f))|((d|D)(o|O)(c|C)))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".msPX"
(define-fun Witness1 () String (seq.++ "." (seq.++ "m" (seq.++ "s" (seq.++ "P" (seq.++ "X" ""))))))
;witness2: "\u00B69.htM\u00C8\u009B\u00D7\xF"
(define-fun Witness2 () String (seq.++ "\xb6" (seq.++ "9" (seq.++ "." (seq.++ "h" (seq.++ "t" (seq.++ "M" (seq.++ "\xc8" (seq.++ "\x9b" (seq.++ "\xd7" (seq.++ "\x0f" "")))))))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "1" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") (re.union (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "X" "X") (re.range "x" "x")))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.union (re.range "L" "L") (re.range "l" "l")))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t")) (re.union (re.range "M" "M") (re.range "m" "m"))))(re.union (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s")) (re.union (re.range "P" "P") (re.range "p" "p"))))(re.union (re.++ (re.union (re.range "T" "T") (re.range "t" "t"))(re.++ (re.union (re.range "X" "X") (re.range "x" "x")) (re.union (re.range "T" "T") (re.range "x" "x"))))(re.union (re.++ (re.union (re.range "M" "M") (re.range "m" "m"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "X" "X") (re.range "x" "x")))))(re.union (re.++ (re.union (re.range "G" "G") (re.range "g" "g"))(re.++ (re.union (re.range "I" "I") (re.range "i" "i")) (re.union (re.range "F" "F") (re.range "f" "f")))) (re.++ (re.union (re.range "D" "D") (re.range "d" "d"))(re.++ (re.union (re.range "O" "O") (re.range "o" "o")) (re.union (re.range "C" "C") (re.range "c" "c")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
