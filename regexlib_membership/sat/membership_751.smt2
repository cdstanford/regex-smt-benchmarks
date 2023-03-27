;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\s]+@[^\.][^\s]{1,}\.[A-Za-z]{2,10}$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x8\u00AC@\x1=.XP"
(define-fun Witness1 () String (str.++ "\u{08}" (str.++ "\u{ac}" (str.++ "@" (str.++ "\u{01}" (str.++ "=" (str.++ "." (str.++ "X" (str.++ "P" "")))))))))
;witness2: "f@\u00B6-bO\u00F2k8\x1EK.bZ"
(define-fun Witness2 () String (str.++ "f" (str.++ "@" (str.++ "\u{b6}" (str.++ "-" (str.++ "b" (str.++ "O" (str.++ "\u{f2}" (str.++ "k" (str.++ "8" (str.++ "\u{1e}" (str.++ "K" (str.++ "." (str.++ "b" (str.++ "Z" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.range "\u{00}" "-") (re.range "/" "\u{ff}"))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))(re.++ (re.range "." ".")(re.++ ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
