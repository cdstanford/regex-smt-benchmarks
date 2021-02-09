;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\w+=[^\s,=]+,)*(\w+=[^\s,=]+,?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00E3=\u00B5,92\u00D69=\u00FB\u00BB,W=K,09\u00BA=d\u00D6,"
(define-fun Witness1 () String (seq.++ "\xe3" (seq.++ "=" (seq.++ "\xb5" (seq.++ "," (seq.++ "9" (seq.++ "2" (seq.++ "\xd6" (seq.++ "9" (seq.++ "=" (seq.++ "\xfb" (seq.++ "\xbb" (seq.++ "," (seq.++ "W" (seq.++ "=" (seq.++ "K" (seq.++ "," (seq.++ "0" (seq.++ "9" (seq.++ "\xba" (seq.++ "=" (seq.++ "d" (seq.++ "\xd6" (seq.++ "," ""))))))))))))))))))))))))
;witness2: "\u00AA\u00C2w=\u00FB\u008A\x18,z=\u00B2d\xE\u008E"
(define-fun Witness2 () String (seq.++ "\xaa" (seq.++ "\xc2" (seq.++ "w" (seq.++ "=" (seq.++ "\xfb" (seq.++ "\x8a" (seq.++ "\x18" (seq.++ "," (seq.++ "z" (seq.++ "=" (seq.++ "\xb2" (seq.++ "d" (seq.++ "\x0e" (seq.++ "\x8e" "")))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "+")(re.union (re.range "-" "<")(re.union (re.range ">" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))) (re.range "," ",")))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\xaa" "\xaa")(re.union (re.range "\xb5" "\xb5")(re.union (re.range "\xba" "\xba")(re.union (re.range "\xc0" "\xd6")(re.union (re.range "\xd8" "\xf6") (re.range "\xf8" "\xff")))))))))))(re.++ (re.range "=" "=")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "+")(re.union (re.range "-" "<")(re.union (re.range ">" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))) (re.opt (re.range "," ",")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
