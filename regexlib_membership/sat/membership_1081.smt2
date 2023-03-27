;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((http|ftp|https):\/\/w{3}[\d]*.|(http|ftp|https):\/\/|w{3}[\d]*.)([\w\d\._\-#\(\)\[\]\\,;:]+@[\w\d\._\-#\(\)\[\]\\,;:])?([a-z0-9]+.)*[a-z\-0-9]+.([a-z]{2,3})?[a-z]{2,6}(:[0-9]+)?(\/[\/a-z0-9\._\-,]+)*[a-z0-9\-_\.\s\%]+(\?[a-z0-9=%&amp;\.\-,#]+)?
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://www4\u0094\u00B5s@\u00CE63grg9%9-\u00ABmayo:1/i8"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "4" (str.++ "\u{94}" (str.++ "\u{b5}" (str.++ "s" (str.++ "@" (str.++ "\u{ce}" (str.++ "6" (str.++ "3" (str.++ "g" (str.++ "r" (str.++ "g" (str.++ "9" (str.++ "%" (str.++ "9" (str.++ "-" (str.++ "\u{ab}" (str.++ "m" (str.++ "a" (str.++ "y" (str.++ "o" (str.++ ":" (str.++ "1" (str.++ "/" (str.++ "i" (str.++ "8" "")))))))))))))))))))))))))))))))))))))
;witness2: "wwwx\u00C6@Fj\u00E0txppjr:82\u00A05\u0085\u00A0%\u0085?r\u00C8\u00A9\u00E2\u00B8"
(define-fun Witness2 () String (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "x" (str.++ "\u{c6}" (str.++ "@" (str.++ "F" (str.++ "j" (str.++ "\u{e0}" (str.++ "t" (str.++ "x" (str.++ "p" (str.++ "p" (str.++ "j" (str.++ "r" (str.++ ":" (str.++ "8" (str.++ "2" (str.++ "\u{a0}" (str.++ "5" (str.++ "\u{85}" (str.++ "\u{a0}" (str.++ "%" (str.++ "\u{85}" (str.++ "?" (str.++ "r" (str.++ "\u{c8}" (str.++ "\u{a9}" (str.++ "\u{e2}" (str.++ "\u{b8}" "")))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" "")))) (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" ""))))))))(re.++ (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))(re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (re.* (re.range "0" "9")) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))(re.union (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.union (str.to_re (str.++ "f" (str.++ "t" (str.++ "p" "")))) (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" "")))))))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" ""))))) (re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (re.* (re.range "0" "9")) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "(" ")")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))(re.++ (re.range "@" "@") (re.union (re.range "#" "#")(re.union (re.range "(" ")")(re.union (re.range "," ".")(re.union (re.range "0" ";")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}"))))))))))))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "0" "9") (re.range "a" "z"))) (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9") (re.range "a" "z"))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.opt ((_ re.loop 2 3) (re.range "a" "z")))(re.++ ((_ re.loop 2 6) (re.range "a" "z"))(re.++ (re.opt (re.++ (re.range ":" ":") (re.+ (re.range "0" "9"))))(re.++ (re.* (re.++ (re.range "/" "/") (re.+ (re.union (re.range "," "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "%" "%")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))) (re.opt (re.++ (re.range "?" "?") (re.+ (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range ";" ";")(re.union (re.range "=" "=") (re.range "a" "z"))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
