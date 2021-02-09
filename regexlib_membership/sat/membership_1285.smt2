;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ( xmlns:.*=[&quot;,'].*[&quot;,'])|( xmlns=[&quot;,'].*[&quot;,'])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00DEy xmlns:\u00F3=u\u00A2\u00A7q\u00F8"
(define-fun Witness1 () String (seq.++ "\xde" (seq.++ "y" (seq.++ " " (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "n" (seq.++ "s" (seq.++ ":" (seq.++ "\xf3" (seq.++ "=" (seq.++ "u" (seq.++ "\xa2" (seq.++ "\xa7" (seq.++ "q" (seq.++ "\xf8" "")))))))))))))))))
;witness2: " xmlns:=o\u00BE\u00C4;"
(define-fun Witness2 () String (seq.++ " " (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "n" (seq.++ "s" (seq.++ ":" (seq.++ "=" (seq.++ "o" (seq.++ "\xbe" (seq.++ "\xc4" (seq.++ ";" "")))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re (seq.++ " " (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "n" (seq.++ "s" (seq.++ ":" ""))))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (re.range "=" "=")(re.++ (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))))))) (re.++ (str.to_re (seq.++ " " (seq.++ "x" (seq.++ "m" (seq.++ "l" (seq.++ "n" (seq.++ "s" (seq.++ "=" ""))))))))(re.++ (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.union (re.range "&" "'")(re.union (re.range "," ",")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
