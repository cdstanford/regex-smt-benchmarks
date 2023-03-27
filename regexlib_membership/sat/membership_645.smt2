;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z]+\-?[a-zA-Z]+
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "XU-Q"
(define-fun Witness1 () String (str.++ "X" (str.++ "U" (str.++ "-" (str.++ "Q" "")))))
;witness2: "T-jp\u00AD"
(define-fun Witness2 () String (str.++ "T" (str.++ "-" (str.++ "j" (str.++ "p" (str.++ "\u{ad}" ""))))))

(assert (= regexA (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.range "-" "-")) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
