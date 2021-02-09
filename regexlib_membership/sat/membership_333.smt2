;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z1-9]*)\.(((a|A)(s|S)(p|P)(x|X))|((h|H)(T|t)(m|M)(l|L))|((h|H)(t|T)(M|m))|((a|A)(s|S)(p|P)))
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "J8.AsPX"
(define-fun Witness1 () String (seq.++ "J" (seq.++ "8" (seq.++ "." (seq.++ "A" (seq.++ "s" (seq.++ "P" (seq.++ "X" ""))))))))
;witness2: "8.Aspx"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "." (seq.++ "A" (seq.++ "s" (seq.++ "p" (seq.++ "x" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "1" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.range "." ".") (re.union (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s"))(re.++ (re.union (re.range "P" "P") (re.range "p" "p")) (re.union (re.range "X" "X") (re.range "x" "x")))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t"))(re.++ (re.union (re.range "M" "M") (re.range "m" "m")) (re.union (re.range "L" "L") (re.range "l" "l")))))(re.union (re.++ (re.union (re.range "H" "H") (re.range "h" "h"))(re.++ (re.union (re.range "T" "T") (re.range "t" "t")) (re.union (re.range "M" "M") (re.range "m" "m")))) (re.++ (re.union (re.range "A" "A") (re.range "a" "a"))(re.++ (re.union (re.range "S" "S") (re.range "s" "s")) (re.union (re.range "P" "P") (re.range "p" "p"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
