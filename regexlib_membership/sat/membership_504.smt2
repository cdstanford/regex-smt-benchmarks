;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(http(s?):\/\/)(www.)?(\w|-)+(\.(\w|-)+)*((\.[a-zA-Z]{2,3})|\.(aero|coop|info|museum|name))+(\/)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://www\u00CE\u00CF.wM.h.YH"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "\u{ce}" (str.++ "\u{cf}" (str.++ "." (str.++ "w" (str.++ "M" (str.++ "." (str.++ "h" (str.++ "." (str.++ "Y" (str.++ "H" ""))))))))))))))))))))))
;witness2: "https://\u00AA.\u00F3\u00F8\u00C8.DZ"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{aa}" (str.++ "." (str.++ "\u{f3}" (str.++ "\u{f8}" (str.++ "\u{c8}" (str.++ "." (str.++ "D" (str.++ "Z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.++ (re.opt (re.range "s" "s")) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))))(re.++ (re.opt (re.++ (str.to_re (str.++ "w" (str.++ "w" (str.++ "w" "")))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))(re.++ (re.* (re.++ (re.range "." ".") (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.+ (re.union (re.++ (re.range "." ".") ((_ re.loop 2 3) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ (re.range "." ".") (re.union (str.to_re (str.++ "a" (str.++ "e" (str.++ "r" (str.++ "o" "")))))(re.union (str.to_re (str.++ "c" (str.++ "o" (str.++ "o" (str.++ "p" "")))))(re.union (str.to_re (str.++ "i" (str.++ "n" (str.++ "f" (str.++ "o" "")))))(re.union (str.to_re (str.++ "m" (str.++ "u" (str.++ "s" (str.++ "e" (str.++ "u" (str.++ "m" ""))))))) (str.to_re (str.++ "n" (str.++ "a" (str.++ "m" (str.++ "e" ""))))))))))))(re.++ (re.opt (re.range "/" "/")) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
