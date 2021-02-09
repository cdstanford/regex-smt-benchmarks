;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = url=\"([^\[\]\"]*)\"
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "X3url=\"\""
(define-fun Witness1 () String (seq.++ "X" (seq.++ "3" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x22" "")))))))))
;witness2: "url=\"|q\"N"
(define-fun Witness2 () String (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" (seq.++ "|" (seq.++ "q" (seq.++ "\x22" (seq.++ "N" ""))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "=" (seq.++ "\x22" ""))))))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "Z")(re.union (re.range "\x5c" "\x5c") (re.range "^" "\xff"))))) (re.range "\x22" "\x22")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
