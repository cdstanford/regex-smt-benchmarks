;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <([^\s>]*)(\s[^<]*)>
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<\u007F\u00DD\u0085j7\'\x1E\u00AF>\u00FD\u00D4\u00FC"
(define-fun Witness1 () String (str.++ "<" (str.++ "\u{7f}" (str.++ "\u{dd}" (str.++ "\u{85}" (str.++ "j" (str.++ "7" (str.++ "'" (str.++ "\u{1e}" (str.++ "\u{af}" (str.++ ">" (str.++ "\u{fd}" (str.++ "\u{d4}" (str.++ "\u{fc}" ""))))))))))))))
;witness2: "\u00C3<\u008E\xB>\x3\u00ACQ\u00BC"
(define-fun Witness2 () String (str.++ "\u{c3}" (str.++ "<" (str.++ "\u{8e}" (str.++ "\u{0b}" (str.++ ">" (str.++ "\u{03}" (str.++ "\u{ac}" (str.++ "Q" (str.++ "\u{bc}" ""))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "=")(re.union (re.range "?" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}")))))))(re.++ (re.++ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))) (re.* (re.union (re.range "\u{00}" ";") (re.range "=" "\u{ff}")))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
