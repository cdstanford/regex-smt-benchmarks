;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z]{1,6}[ ']){0,3}([ÉÈÊËÜÛÎÔÄÏÖÄÅÇA-Z]{1}[éèëêüûçîôâïöäåa-z]{2,}[- ']){0,3}[A-Z]{1}[éèëêüûçîôâïöäåa-z]{2,}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "l z B\u00E7\u00FBv\'M\u00E2t"
(define-fun Witness1 () String (str.++ "l" (str.++ " " (str.++ "z" (str.++ " " (str.++ "B" (str.++ "\u{e7}" (str.++ "\u{fb}" (str.++ "v" (str.++ "'" (str.++ "M" (str.++ "\u{e2}" (str.++ "t" "")))))))))))))
;witness2: "jly\'z \u00DC\u00EFe N\u00EFcz Y\u00EEy\u00FB\u00E7\u00E7\u00E7r"
(define-fun Witness2 () String (str.++ "j" (str.++ "l" (str.++ "y" (str.++ "'" (str.++ "z" (str.++ " " (str.++ "\u{dc}" (str.++ "\u{ef}" (str.++ "e" (str.++ " " (str.++ "N" (str.++ "\u{ef}" (str.++ "c" (str.++ "z" (str.++ " " (str.++ "Y" (str.++ "\u{ee}" (str.++ "y" (str.++ "\u{fb}" (str.++ "\u{e7}" (str.++ "\u{e7}" (str.++ "\u{e7}" (str.++ "r" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 3) (re.++ ((_ re.loop 1 6) (re.range "a" "z")) (re.union (re.range " " " ") (re.range "'" "'"))))(re.++ ((_ re.loop 0 3) (re.++ (re.union (re.range "A" "Z")(re.union (re.range "\u{c4}" "\u{c5}")(re.union (re.range "\u{c7}" "\u{cb}")(re.union (re.range "\u{ce}" "\u{cf}")(re.union (re.range "\u{d4}" "\u{d4}")(re.union (re.range "\u{d6}" "\u{d6}") (re.range "\u{db}" "\u{dc}")))))))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "a" "z")(re.union (re.range "\u{e2}" "\u{e2}")(re.union (re.range "\u{e4}" "\u{e5}")(re.union (re.range "\u{e7}" "\u{eb}")(re.union (re.range "\u{ee}" "\u{ef}")(re.union (re.range "\u{f4}" "\u{f4}")(re.union (re.range "\u{f6}" "\u{f6}") (re.range "\u{fb}" "\u{fc}"))))))))) (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e2}" "\u{e2}")(re.union (re.range "\u{e4}" "\u{e5}")(re.union (re.range "\u{e7}" "\u{eb}")(re.union (re.range "\u{ee}" "\u{ef}")(re.union (re.range "\u{f4}" "\u{f4}")(re.union (re.range "\u{f6}" "\u{f6}") (re.range "\u{fb}" "\u{fc}")))))))))) (re.union (re.range " " " ")(re.union (re.range "'" "'") (re.range "-" "-"))))))(re.++ (re.range "A" "Z")(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "a" "z")(re.union (re.range "\u{e2}" "\u{e2}")(re.union (re.range "\u{e4}" "\u{e5}")(re.union (re.range "\u{e7}" "\u{eb}")(re.union (re.range "\u{ee}" "\u{ef}")(re.union (re.range "\u{f4}" "\u{f4}")(re.union (re.range "\u{f6}" "\u{f6}") (re.range "\u{fb}" "\u{fc}"))))))))) (re.* (re.union (re.range "a" "z")(re.union (re.range "\u{e2}" "\u{e2}")(re.union (re.range "\u{e4}" "\u{e5}")(re.union (re.range "\u{e7}" "\u{eb}")(re.union (re.range "\u{ee}" "\u{ef}")(re.union (re.range "\u{f4}" "\u{f4}")(re.union (re.range "\u{f6}" "\u{f6}") (re.range "\u{fb}" "\u{fc}")))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
