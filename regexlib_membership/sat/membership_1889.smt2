;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (AUX|PRN|NUL|COM\d|LPT\d)+\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\xECOM3\u00A0\xD"
(define-fun Witness1 () String (seq.++ "\x0e" (seq.++ "C" (seq.++ "O" (seq.++ "M" (seq.++ "3" (seq.++ "\xa0" (seq.++ "\x0d" ""))))))))
;witness2: "PRNLPT1LPT9AUX\u00A0 "
(define-fun Witness2 () String (seq.++ "P" (seq.++ "R" (seq.++ "N" (seq.++ "L" (seq.++ "P" (seq.++ "T" (seq.++ "1" (seq.++ "L" (seq.++ "P" (seq.++ "T" (seq.++ "9" (seq.++ "A" (seq.++ "U" (seq.++ "X" (seq.++ "\xa0" (seq.++ " " "")))))))))))))))))

(assert (= regexA (re.++ (re.+ (re.union (str.to_re (seq.++ "A" (seq.++ "U" (seq.++ "X" ""))))(re.union (str.to_re (seq.++ "P" (seq.++ "R" (seq.++ "N" ""))))(re.union (str.to_re (seq.++ "N" (seq.++ "U" (seq.++ "L" ""))))(re.union (re.++ (str.to_re (seq.++ "C" (seq.++ "O" (seq.++ "M" "")))) (re.range "0" "9")) (re.++ (str.to_re (seq.++ "L" (seq.++ "P" (seq.++ "T" "")))) (re.range "0" "9")))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
