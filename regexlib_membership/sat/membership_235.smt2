;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = function[\s]+[\S]+[\s]*([\s]*)[\s]*{[\s]*([\S]|[\s])*[\s]*}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ufunction\x9\u00AB\xC {\x9}\x16\u009D"
(define-fun Witness1 () String (str.++ "u" (str.++ "f" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "\u{09}" (str.++ "\u{ab}" (str.++ "\u{0c}" (str.++ " " (str.++ "{" (str.++ "\u{09}" (str.++ "}" (str.++ "\u{16}" (str.++ "\u{9d}" "")))))))))))))))))))
;witness2: "function\u00A0\x4\xA{ \u00B6}\u00AE"
(define-fun Witness2 () String (str.++ "f" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" (str.++ "\u{a0}" (str.++ "\u{04}" (str.++ "\u{0a}" (str.++ "{" (str.++ " " (str.++ "\u{b6}" (str.++ "}" (str.++ "\u{ae}" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "f" (str.++ "u" (str.++ "n" (str.++ "c" (str.++ "t" (str.++ "i" (str.++ "o" (str.++ "n" "")))))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "{" "{")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.* (re.range "\u{00}" "\u{ff}"))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "}" "}")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
