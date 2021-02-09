;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-Z][a-z]+)\s([A-Z][a-zA-Z-]+)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Lp\xBW-k"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "p" (seq.++ "\x0b" (seq.++ "W" (seq.++ "-" (seq.++ "k" "")))))))
;witness2: "Mf\u0085Q-"
(define-fun Witness2 () String (seq.++ "M" (seq.++ "f" (seq.++ "\x85" (seq.++ "Q" (seq.++ "-" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.++ (re.range "A" "Z") (re.+ (re.union (re.range "-" "-")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
