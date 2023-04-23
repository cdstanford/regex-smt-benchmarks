;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9\x20'\.]{8,64}[^\s]$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "xMlN8F.e\u009A"
(define-fun Witness1 () String (str.++ "x" (str.++ "M" (str.++ "l" (str.++ "N" (str.++ "8" (str.++ "F" (str.++ "." (str.++ "e" (str.++ "\u{9a}" ""))))))))))
;witness2: "s9..z9p9\u008A"
(define-fun Witness2 () String (str.++ "s" (str.++ "9" (str.++ "." (str.++ "." (str.++ "z" (str.++ "9" (str.++ "p" (str.++ "9" (str.++ "\u{8a}" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 8 64) (re.union (re.range " " " ")(re.union (re.range "'" "'")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))(re.++ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
