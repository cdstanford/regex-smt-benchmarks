;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z]{1}[a-z0-9\-_\.]{2,24})@tlen\.pl$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "z1pa_@tlen.pl"
(define-fun Witness1 () String (seq.++ "z" (seq.++ "1" (seq.++ "p" (seq.++ "a" (seq.++ "_" (seq.++ "@" (seq.++ "t" (seq.++ "l" (seq.++ "e" (seq.++ "n" (seq.++ "." (seq.++ "p" (seq.++ "l" ""))))))))))))))
;witness2: "s____yz@tlen.pl"
(define-fun Witness2 () String (seq.++ "s" (seq.++ "_" (seq.++ "_" (seq.++ "_" (seq.++ "_" (seq.++ "y" (seq.++ "z" (seq.++ "@" (seq.++ "t" (seq.++ "l" (seq.++ "e" (seq.++ "n" (seq.++ "." (seq.++ "p" (seq.++ "l" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "a" "z") ((_ re.loop 2 24) (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (str.to_re (seq.++ "@" (seq.++ "t" (seq.++ "l" (seq.++ "e" (seq.++ "n" (seq.++ "." (seq.++ "p" (seq.++ "l" ""))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
