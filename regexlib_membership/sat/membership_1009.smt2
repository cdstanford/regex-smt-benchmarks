;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = target[ ]*[=]([ ]*)([&quot;]|['])*([_])*([A-Za-z0-9])+([&quot;])*
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "target =;oi"
(define-fun Witness1 () String (str.++ "t" (str.++ "a" (str.++ "r" (str.++ "g" (str.++ "e" (str.++ "t" (str.++ " " (str.++ "=" (str.++ ";" (str.++ "o" (str.++ "i" ""))))))))))))
;witness2: "\u00DD6target=_____K9o&;a"
(define-fun Witness2 () String (str.++ "\u{dd}" (str.++ "6" (str.++ "t" (str.++ "a" (str.++ "r" (str.++ "g" (str.++ "e" (str.++ "t" (str.++ "=" (str.++ "_" (str.++ "_" (str.++ "_" (str.++ "_" (str.++ "_" (str.++ "K" (str.++ "9" (str.++ "o" (str.++ "&" (str.++ ";" (str.++ "a" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "t" (str.++ "a" (str.++ "r" (str.++ "g" (str.++ "e" (str.++ "t" "")))))))(re.++ (re.* (re.range " " " "))(re.++ (re.range "=" "=")(re.++ (re.* (re.range " " " "))(re.++ (re.* (re.union (re.range "&" "'")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u"))))))(re.++ (re.* (re.range "_" "_"))(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.* (re.union (re.range "&" "&")(re.union (re.range ";" ";")(re.union (re.range "o" "o")(re.union (re.range "q" "q") (re.range "t" "u")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
