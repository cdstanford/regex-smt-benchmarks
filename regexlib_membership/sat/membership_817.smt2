;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-z0-9]+[@]{1}[a-zA-Z]+[.]{1}[a-zA-Z]+$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "qC8@H.m"
(define-fun Witness1 () String (seq.++ "q" (seq.++ "C" (seq.++ "8" (seq.++ "@" (seq.++ "H" (seq.++ "." (seq.++ "m" ""))))))))
;witness2: "9N@YS.a"
(define-fun Witness2 () String (seq.++ "9" (seq.++ "N" (seq.++ "@" (seq.++ "Y" (seq.++ "S" (seq.++ "." (seq.++ "a" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9") (re.range "A" "z")))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
