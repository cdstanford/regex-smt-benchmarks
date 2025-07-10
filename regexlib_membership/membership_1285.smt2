;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ( xmlns:.*=[&quot;,'].*[&quot;,'])|( xmlns=[&quot;,'].*[&quot;,'])
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00DEy xmlns:\u00F3=u\u00A2\u00A7q\u00F8"
(define-fun Witness1 () String (str.++ "\u{de}" (str.++ "y" (str.++ " " (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "n" (str.++ "s" (str.++ ":" (str.++ "\u{f3}" (str.++ "=" (str.++ "u" (str.++ "\u{a2}" (str.++ "\u{a7}" (str.++ "q" (str.++ "\u{f8}" "")))))))))))))))))
;witness2: " xmlns:=o\u00BE\u00C4;"
(define-fun Witness2 () String (str.++ " " (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "n" (str.++ "s" (str.++ ":" (str.++ "=" (str.++ "o" (str.++ "\u{be}" (str.++ "\u{c4}" (str.++ ";" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (str.++ " " (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "n" (str.++ "s" (str.++ ":" ""))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))))))) (re.++ (str.to_re (str.++ " " (str.++ "x" (str.++ "m" (str.++ "l" (str.++ "n" (str.++ "s" (str.++ "=" ""))))))))(re.++ (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
