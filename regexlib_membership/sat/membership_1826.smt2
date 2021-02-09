;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z][0-9][a-zA-Z]\s?[0-9][a-zA-Z][0-9]$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "s6X\u00853i8"
(define-fun Witness1 () String (seq.++ "s" (seq.++ "6" (seq.++ "X" (seq.++ "\x85" (seq.++ "3" (seq.++ "i" (seq.++ "8" ""))))))))
;witness2: "Z9x4e0"
(define-fun Witness2 () String (seq.++ "Z" (seq.++ "9" (seq.++ "x" (seq.++ "4" (seq.++ "e" (seq.++ "0" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "0" "9")(re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))(re.++ (re.range "0" "9") (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
