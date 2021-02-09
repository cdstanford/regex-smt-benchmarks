;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-z]{1,6}[ ']){0,3}([ÉÈÊËÜÛÎÔÄÏÖÄÅÇA-Z]{1}[éèëêüûçîôâïöäåa-z]{2,}[- ']){0,3}[A-Z]{1}[éèëêüûçîôâïöäåa-z]{2,}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "l z B\u00E7\u00FBv\'M\u00E2t"
(define-fun Witness1 () String (seq.++ "l" (seq.++ " " (seq.++ "z" (seq.++ " " (seq.++ "B" (seq.++ "\xe7" (seq.++ "\xfb" (seq.++ "v" (seq.++ "'" (seq.++ "M" (seq.++ "\xe2" (seq.++ "t" "")))))))))))))
;witness2: "jly\'z \u00DC\u00EFe N\u00EFcz Y\u00EEy\u00FB\u00E7\u00E7\u00E7r"
(define-fun Witness2 () String (seq.++ "j" (seq.++ "l" (seq.++ "y" (seq.++ "'" (seq.++ "z" (seq.++ " " (seq.++ "\xdc" (seq.++ "\xef" (seq.++ "e" (seq.++ " " (seq.++ "N" (seq.++ "\xef" (seq.++ "c" (seq.++ "z" (seq.++ " " (seq.++ "Y" (seq.++ "\xee" (seq.++ "y" (seq.++ "\xfb" (seq.++ "\xe7" (seq.++ "\xe7" (seq.++ "\xe7" (seq.++ "r" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 0 3) (re.++ ((_ re.loop 1 6) (re.range "a" "z")) (re.union (re.range " " " ") (re.range "'" "'"))))(re.++ ((_ re.loop 0 3) (re.++ (re.union (re.range "A" "Z")(re.union (re.range "\xc4" "\xc5")(re.union (re.range "\xc7" "\xcb")(re.union (re.range "\xce" "\xcf")(re.union (re.range "\xd4" "\xd4")(re.union (re.range "\xd6" "\xd6") (re.range "\xdb" "\xdc")))))))(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "a" "z")(re.union (re.range "\xe2" "\xe2")(re.union (re.range "\xe4" "\xe5")(re.union (re.range "\xe7" "\xeb")(re.union (re.range "\xee" "\xef")(re.union (re.range "\xf4" "\xf4")(re.union (re.range "\xf6" "\xf6") (re.range "\xfb" "\xfc"))))))))) (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe2" "\xe2")(re.union (re.range "\xe4" "\xe5")(re.union (re.range "\xe7" "\xeb")(re.union (re.range "\xee" "\xef")(re.union (re.range "\xf4" "\xf4")(re.union (re.range "\xf6" "\xf6") (re.range "\xfb" "\xfc")))))))))) (re.union (re.range " " " ")(re.union (re.range "'" "'") (re.range "-" "-"))))))(re.++ (re.range "A" "Z")(re.++ (re.++ ((_ re.loop 2 2) (re.union (re.range "a" "z")(re.union (re.range "\xe2" "\xe2")(re.union (re.range "\xe4" "\xe5")(re.union (re.range "\xe7" "\xeb")(re.union (re.range "\xee" "\xef")(re.union (re.range "\xf4" "\xf4")(re.union (re.range "\xf6" "\xf6") (re.range "\xfb" "\xfc"))))))))) (re.* (re.union (re.range "a" "z")(re.union (re.range "\xe2" "\xe2")(re.union (re.range "\xe4" "\xe5")(re.union (re.range "\xe7" "\xeb")(re.union (re.range "\xee" "\xef")(re.union (re.range "\xf4" "\xf4")(re.union (re.range "\xf6" "\xf6") (re.range "\xfb" "\xfc")))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
